$ ->
  class window.TopBid extends Backbone.Model
    defaults:
      user: 'anonymous'
      amount: 0
      timestamp: new Date().toUTCString()

  class window.TopBids extends Backbone.Collection
    model: TopBid

  class window.TopBidView extends Backbone.View
    tagName: 'div'
    className: 'container'

    initialize: ->
      _.bindAll @

    render: ->
      $(@el).html """
                  <p class="muted credit">
                    The current highest bid placed is <strong id='winningAmount'>&euro; #{@model.get 'amount'}</strong> by <span id='winner'>#{@model.get 'user'}</span>
                  </p>
                  """
      $('#bid').val(parseInt(@model.get 'amount') + 5)
      @

  class window.TopBidsView extends Backbone.View
    el: $ '#topbidsArea'

    initialize: ->
      _.bindAll @

      @topBids = new TopBids
      @topBids.bind 'add', @renderBid

      @render()

    handleNewTopBid: (topBidJson)->
      if topBidJson
        topBidHash = JSON.parse(topBidJson)
        topBid     = new TopBid(topBidHash)

        @topBids.add topBid

    renderBid: (topBid) ->
      topBidView = new TopBidView model: topBid

      $('#footer').html topBidView.render().el


  topBidsView = new TopBidsView

  socket = io.connect('http://localhost:4000')

  socket.on 'newtopbid', (topBid)->
    topBidsView.handleNewTopBid(topBid)

  socket.on 'bidHistory', (data) ->
    topBidsView.handleNewTopBid(data[0])
