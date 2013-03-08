$ ->
  class window.TopBid extends Backbone.Model
    defaults:
      user: 'anonymous'
      amount: 0
      timestamp: new Date().toUTCString()

  class window.TopBids extends Backbone.Collection
    model: TopBid

  class window.TopBidView extends Backbone.View
    tagName: 'li'

    initialize: ->
      _.bindAll @

    render: ->
      console.log("render top bid")
      $(@el).html """
                  <span>
                      #{@model.get 'user'} bid #{@model.get 'amount'}
                  </span>
                  """
      @

  class window.TopBidsView extends Backbone.View
    el: $ '#topbidsArea'

    initialize: ->
      _.bindAll @

      @topBids = new TopBids
      @topBids.bind 'add', @prependBid

      @render()

    handleNewTopBid: (topBidHash)->
      console.log("new top bid " + topBidHash)
      topBid = new TopBid {
        user: topBidHash.user
        amount: topBidHash.amount
      }
      console.log("adding top bid " + topBid)
      @topBids.add topBid

    prependBid: (topBid) ->
      console.log("prepending top bid")
      topBidView = new TopBidView model: topBid
      $('#topbids').prepend topBidView.render().el


  topBidsView = new TopBidsView

  socket = io.connect('http://localhost:4000')

  socket.on 'newtopbid', (topBid)->
    topBidsView.handleNewTopBid(topBid)