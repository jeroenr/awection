$ ->

  class window.Bid extends Backbone.Model
    defaults:
      user: 'anonymous'
      amount: 0

  class window.Bids extends Backbone.Collection
    model: Bid
    url:  'http://localhost:3000/bids'


  class window.BidView extends Backbone.View
    tagName: 'li'

    initialize: ->
      _.bindAll @

    render: ->
      $(@el).html """
                  <span>
                    #{@model.get 'user'} bid #{@model.get 'amount'}
                  </span>
                  """
      @

  class window.BidsView extends Backbone.View

    el: $ '#bidArea'

    initialize: ->
      _.bindAll @

      @bids = new Bids
      @bids.bind 'add', @prependBid

      @counter = 0
      @render()

    handleNewBid: ->
      @counter++
      inputField = $('#bid')
      bid = new Bid {
      user: "user #{@counter}",
      amount: inputField.val()
      }
      @bids.add bid
      bid.save()
      inputField.val ''

    prependBid: (bid) ->
      bidView = new BidView model: bid
      $('#bids').prepend bidView.render().el

    events:
      'click #submitBid': 'handleNewBid'

  class window.TopBid extends Backbone.Model
    defaults:
          user: 'anonymous'
          amount: 0

  window.topBid = new window.TopBid

  bidsView = new BidsView
  ws = new WebSocket("ws://localhost:8080")

  ws.onmessage = (event)->
    $('body').append """
                     <p>Top bid: #{event.data}</p>
                     """