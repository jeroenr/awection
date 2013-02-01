$ ->

  class Bid extends Backbone.Model
    defaults:
      user: 'anonymous'
      amount: 0

  class Bids extends Backbone.Collection
    model: Bid
    url:  'http://localhost:9292/bids'


  class BidView extends Backbone.View
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

  class BidsView extends Backbone.View

    el: $ '#bidArea'

    initialize: ->
      _.bindAll @

      @bids = new Bids
      @bids.bind 'create', @prependBid

      @counter = 0
      @render()

    handleNewBid: ->
      @counter++
      inputField = $('#bid')
      @bids.create {
        user: "user #{@counter}"
        amount: inputField.val
      }
      inputField.val ''

    prependBid: (bid) ->
      bidView = new BidView model: bid
      $('#bids').prepend bidView.render().el

    render: ->
      $(@el).append """
                    <h2>Bids</h2>
                    <ul id='bids'></ul>
                      <div>
                        <input id='bid' name='bid' type="text" />
                        <a href="#" id="submitBid">Bid</a>
                      </div>
                    """

    events:
      'click #submitBid': 'handleNewBid'

  bidsView = new BidsView