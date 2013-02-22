var express = require('express')
  , app = express()
  , server = require('http').createServer(app)
  , io = require('socket.io').listen(server)
  , _ = require('underscore')
  , db = require('redis').createClient();

app.listen(4000);

// authentication
//var dbAuth = function() { db.auth('dc64f7b818f4e3ec2e3d3d033e3e5ff4'); }
//db.addListener('connected', dbAuth);
//db.addListener('reconnected', dbAuth);
//dbAuth();

io.sockets.on('connection', function (socket) {
        console.log("user connected #{socket}")
	// search result hooks
        db.subscribe("top_bids_channel");
	db.on("message", function(channel, message) {
		console.log("new top bid");
		socket.broadcast.emit('newtopbid', 'SERVER', message);                
        });
});
