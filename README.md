Awection
========

Little redis backed auction site. It's an auction. It's awesome. It's an awection!

Basic architecture
------------------

### Backend
AuctionEngine (Sinatra) --publish--> Redis <--subscribe-- WebSocket Handler (Node.JS / Socket.io)

### Frontend
AuctionEngine (Sinatra) --bids (JSON)--> view (Backbone.js) <--top bids (JSON)-- WebSocket Handler (Node.JS / Socket.io)

Sinatra + Assets + Backbone
---------------------------
It's a sinatra app using the asset pack to serve my CoffeeScript files. The view is build with Backbone.js.

Redis
-----
I'm using a Redis queue to process bids. When a bid comes in which is currently the highest it's published to a redis channel.

Websocket handler
-----------------
The Websocket handler is a Node.js app using Socket.io for the fallback. The Websocket handler subscribes to the redis top bids channel. When a bid comes in it's broadcasted to the clients.
