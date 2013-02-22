var express = require('express')
  , app = express()
  , server = app.listen(4000) 
  , sio = require('socket.io') 
  , io = sio.listen(server)
  , db = require('redis').createClient();

// authentication
//var dbAuth = function() { db.auth('dc64f7b818f4e3ec2e3d3d033e3e5ff4'); }
//db.addListener('connected', dbAuth);
//db.addListener('reconnected', dbAuth);
//dbAuth();

io.sockets.on('connection', function (socket) {
	db.subscribe("top_bids_channel");
	db.on("message", function(channel, message) {
		socket.emit('newtopbid', message);                
        });
});
