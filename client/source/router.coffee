# Application.
define [
  "app"
  "backbone.io"
  "modules/Location"
], (app, Backbone, Location) ->
  
  # Defining the application router, you can attach sub routers here.
  Router = Backbone.Router.extend(
    routes:
      "": "index"
    
    initialize: ->
      Backbone.io.connect()
      app.locations = new Location.Collection()
      
    index: ->
      locationGrid = new Location.Views.Grid
        collection: app.locations
        
      app.useLayout
        template: 'home'
        
      app.layout.setViews
        '.grid': locationGrid
      
      app.locations.fetch()
  )
  
  return Router

