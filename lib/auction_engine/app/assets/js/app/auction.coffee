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
        [padded_minutes, padded_seconds] = [(@model.get 'minutes'),(@model.get 'seconds')].map (_) -> String("00#{_}").slice(-2)
        String("00#{_}").slice(-2)
        $(@el).html """
                    <h1>
                      #{padded_minutes}:#{padded_seconds}
                    </h1>
                    """
        @

  timeLeft = new TimeLeft
  timeLeftView = new TimeLeftView model: timeLeft

  timeLeftView.render()

  socket = io.connect('http://localhost:4000')

  socket.on 'tick', (timeUpdate)->
    timeLeft.set(timeUpdate)
    timeLeftView.render()

