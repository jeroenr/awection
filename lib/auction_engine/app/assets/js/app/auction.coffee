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
                      #{padded_minutes}:#{padded_seconds}
                    """
        @

  timeLeft = new TimeLeft
  timeLeftView = new TimeLeftView model: timeLeft

  timeLeftView.render()

  populateParticipants = (participants) ->
    participantList = $('#participants-list')

    participantList.empty()
    participantList.append("""<li>#{participant}</li>""" ) for participant in participants

  socket.on 'remaining_participants', (remainingParticipants) ->
      console.log remainingParticipants

  socket.on 'new_participant', (participantsRoom) -> populateParticipants(participantsRoom.all)
  socket.on 'participant_left', (participantsRoom) -> populateParticipants(participantsRoom.all)


  socket.on 'tick', (timeUpdate)->
    timeLeft.set(timeUpdate)
    timeLeftView.render()

  socket.on 'timeup', (timeUpdate) ->
    $('#submitBid').attr('disabled','disabled')
    winner = $('#winner').html()
    amount = $('#winningAmount').html()
    announcement = noty({type: 'success', layout: 'center', text: """#{winner} is going on holiday for #{amount}. Congrats! """})
