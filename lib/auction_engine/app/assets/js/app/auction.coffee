$ ->

  class window.TimeLeft extends Backbone.Model
      defaults:
        minutes: 10
        seconds: 0

  class window.TimeLeftView extends Backbone.View
      el: $ '#clock'

      initialize: ->
        _.bindAll @

      render: ->
        $(@el).html """
                    <span>
                      #{@model.get 'minutes'} bid #{@model.get 'seconds'}
                    </span>
                    """
      @

  timeLeft = new TimeLeft

  socket = io.connect('http://localhost:4000')

  socket.on 'tick', (timeUpdate)->
    timeLeft.set(timeUpdate)
