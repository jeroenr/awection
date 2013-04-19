$ ->
  class window.Session extends Backbone.Model
    defaults:
      user_id: null

    initialize: ->
      @load

    authenticated: ->
      Boolean(@get('user_id'))

    load: ->
      @set
        user_id: $.cookie('user_id')

  window.session = new Session()
