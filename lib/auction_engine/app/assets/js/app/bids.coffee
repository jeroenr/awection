$ ->

  class window.Bid extends Backbone.Model
    defaults:
      user: 'anonymous'
      amount: 0

  class window.Bids extends Backbone.Collection
    model: Bid
    url:  'http://localhost:9292/bids'


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
      @bids.add new Bid {
              user: "user #{@counter}",
              amount: inputField.val()
            }

      inputField.val ''

    prependBid: (bid) ->
      bidView = new BidView model: bid
      $('#bids').prepend bidView.render().el

    render: ->
      $(@el).append """
                    <h2>User bid history</h2>
                    <ul id='bids'></ul>
                      <div>
                        <input id='bid' name='bid' type="text" />
                        <a href="#" id="submitBid">Bid</a>
                      </div>
                    """

    events:
      'click #submitBid': 'handleNewBid'

  class window.TopBid extends Backbone.Model
    defaults:
          user: 'anonymous'
          amount: 0

  window.topBid = new window.TopBid

  bidsView = new BidsView

  pusher = new Pusher(10)

  topBidChannel = pusher.subscribe('highest-bid')
  backPusher = new Backpusher(topBidChannel, window.topBid)