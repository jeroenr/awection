$ ->
  class window.Session extends Backbone.Model
    defaults:
      user_id: null

    initialize: ->
      @load()

    authenticated: ->
      Boolean(@get('user_id'))

    load: ->
      @set
        user_id: $.cookie('user_id') or @setCookie

    setCookie: ->
      key = Math.random().toString(36).substr(2)

      $.cookie('user_id', key, expires: 1)

      return key

  window.session = new Session()
