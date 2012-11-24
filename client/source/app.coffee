define ["backbone.layoutmanager"], ->
  
  # Provide a global location to place configuration settings and module
  # creation.
  
  # The root path to run the application.
  app = root: "/"
  
  # Localize or create a new JavaScript Template object.
  JST = window.JST = window.JST or {}
  
  # Configure LayoutManager with Backbone Boilerplate defaults.
  Backbone.LayoutManager.configure
    
    # Allow LayoutManager to augment Backbone.View.prototype.
    manage: true
    prefix: "app/templates/"
    fetch: (path) ->
      
      # Concatenate the file extension.
      path = path + ".html"
      
      # If cached, use the compiled template.
      return JST[path]  if JST[path]
      
      # Put fetch into `async-mode`.
      done = @async()
      
      # Seek out the template asynchronously.
      $.get app.root + path, (contents) ->
        done JST[path] = _.template(contents)


  
  # Mix Backbone.Events, modules, and layout management into the app object.
  _.extend app,
    
    # Create a custom object with a nested Views object.
    module: (additionalProps) ->
      _.extend
        Views: {}
      , additionalProps

    
    # Helper for using layouts.
    useLayout: (options) ->
      
      # Create a new Layout with options.
      layout = new Backbone.Layout(_.extend(
        el: "body"
      , options))
      
      # Cache the refererence.
      @layout = layout
  , Backbone.Events

