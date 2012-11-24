# Application.
define [
  "app"
  "backbone.io"
], (app, Backbone) ->
  
  # Defining the application router, you can attach sub routers here.
  Router = Backbone.Router.extend(
    routes:
      "": "index"
    
    initialize: ->
      Backbone.io.connect()
      
    index: ->
      console.log('got here');
  )
  
  return Router

