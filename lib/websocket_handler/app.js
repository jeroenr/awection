var express = require('express')
  , app = express()
  , server = app.listen(4000) 
  , sio = require('socket.io') 
  , io = sio.listen(server)
  , redis = require('redis');

var topBidsSubscriber = redis.createClient()
  , auctionSubscriber = redis.createClient();

var AUCTION_TIME_LIMIT = 600000; // 10 minutes

var Timer = require('./timer');
var timer = new Timer(AUCTION_TIME_LIMIT);

auctionSubscriber.subscribe("auction_channel");
//auctionSubscriber.on("message", function(channel, message) {
	// switch (message) {
		// case "start":
			timer.start();
			//break;
		// case "stop":
			// timer.stop();
			//break;
		// default:
			//break;
	// }
// });

io.sockets.on('connection', function (socket) {
	topBidsSubscriber.subscribe("top_bids_channel");
	topBidsSubscriber.on("message", function(channel, message) {
		socket.emit('newtopbid', message);                
    });

	// auction timer events
	timer.on('tick', function(timeUpdate) {
		socket.emit('tick', timeUpdate);
	});

	timer.on('timeup', function(timePassed) {
		socket.emit('timeup', timePassed);
	});

	
});
