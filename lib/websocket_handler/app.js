var express = require('express'),
    sio     = require('socket.io'),
    _       = require('underscore'),
    redis   = require('redis'),
    app     = express(),
    server  = app.listen(4000),
    io      = sio.listen(server);

var db                = redis.createClient(),
    topBidsSubscriber = redis.createClient(),
    newBidSubscriber  = redis.createClient();


var AUCTION_TIME_LIMIT = 600000; // 10 minutes
// var AUCTION_TIME_LIMIT = 10000; // 10 seconds
var NEEDED_PARTICIPANTS = 2;

var Timer = require('./timer');
var timer = new Timer(AUCTION_TIME_LIMIT);

function start() {
  db.flushall();
  timer.restart();
}

var participants = "67854387345";
io.sockets.on('connection', function (socket) {

  socket.on('participate', function(user_id) {
    socket.userId = user_id;
    var all = io.sockets.clients(participants);
    var allUserIds = _.map(all, function(s){ return s.userId; });

    if(!_.contains(allUserIds, user_id)){
      allUserIds.push(user_id);
      socket.join(participants);
      console.log("participants: " + allUserIds);
      io.sockets.in(participants).emit('new_participant', { joined: user_id, all: allUserIds})

      var needed = (NEEDED_PARTICIPANTS - allUserIds.length);
      if (needed === 0) {
        start();
      } else {
        io.sockets.in(participants).emit('remaining_participants', needed);
      }
    }
  });

  socket.on('disconnect', function(){
    socket.leave(participants);
    var all = io.sockets.clients(participants);
    var allUserIds = _.map(all, function(s){ return s.userId; });
    console.log("remaining participants: " + allUserIds);
    io.sockets.in(participants).emit('participant_left', { left: socket.userId, all: allUserIds })
  })


  db.lrange('top_bids_cache', 0, 10, function(err, result) {
    socket.emit('bidHistory', result);
  });

	topBidsSubscriber.subscribe("top_bids_channel");

	topBidsSubscriber.on("message", function(channel, message) {
		socket.emit('newtopbid', message);
  });

  newBidSubscriber.subscribe('bid_queue');
  newBidSubscriber.on('message', function(channel, message) {
    socket.emit('newbid', message);
  });

	// auction timer events
	timer.on('tick', function(timeUpdate) {
		socket.emit('tick', timeUpdate);
	});

	timer.on('timeup', function(timePassed) {
		socket.emit('timeup', timePassed);
	});
});
