var util = require('util')
  , events = require('events')
  , _ = require('underscore');


function Timer(timeInMillis) {

	if(false === (this instanceof Timer)) {
		return new Timer(timeInMillis);
	}
	this.timeInMillis = timeInMillis;

	this.minute = 60000;
    this.second = 1000;
    this.remaining = this.timeInMillis;
    this.interval = undefined;

    events.EventEmitter.call(this);

    // Use Underscore to bind all of our methods
    // to the proper context
    _.bindAll(this);
};

// inherit from EventEmitter
util.inherits(Timer, events.EventEmitter);

Timer.prototype.onTick = function() {
	if(this.remaining === 0) {
		this.stop();
		this.emit('timeup', this.timeInMillis);
	}

	remainder = this.remaining;
	minutesRemaining = Math.floor(remainder / this.minute);
	remainder -= minutesRemaining * this.minute;

	secondsRemaining = remainder / this.second;
	remainder -= secondsRemaining * this.second;

	output = {
		minutes: minutesRemaining,
		seconds: secondsRemaining
	};

	this.emit('tick', output);
	this.remaining -= this.second;
}

Timer.prototype.start = function() {
	console.log("Starting timer");
	// call onTick every second
	this.interval = setInterval(this.onTick, this.second);
	this.emit('started', this.remaining);
}

Timer.prototype.stop = function() {
	console.log("Stopping timer");
	if (this.interval) {
        clearInterval(this.interval);
        this.emit('stopped', this.remaining);
    }
}

module.exports = Timer;