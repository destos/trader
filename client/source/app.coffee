define [
  "handlebars"
  "backbone.layoutmanager"
], (Handlebars) ->
  
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
      
      # If cached, use the compiled template.
      return JST[path]  if JST[path]
      
      # Put fetch into `async-mode`.
      done = @async()
      
      # Seek out the template asynchronously.
      $.get "#{app.root}#{path}.hbs", (contents) ->
        done JST[path] = Handlebars.compile(contents)
      
      # return done
    
    # render: (template, context) ->
    #   try
    #       return template(context)
    #   catch e
    #       console.warn "error rendering: #{@template}"
    #       console.error e
  
  # Mix Backbone.Events, modules, and layout management into the app object.
  _.extend app,
    
    # Create a custom object with a nested Views object.
    module: (additionalProps) ->
      _.extend
        Views: {}
      , additionalProps

    
    # Helper for using layouts.
    useLayout: (options) ->
      name = options.template
      options.template = "layouts/#{options.template}"
      # If already using this Layout, then don't re-inject into the DOM.
      return @layout  if @layout and @layout.options.template is options.template
      
      # If a layout already exists, remove it from the DOM.
      @layout.remove()  if @layout
      
      # Create a new Layout with options.
      layout = new Backbone.Layout(_.extend(
        className: "layout #{name}"
        id: "layout"
      , options))
      
      # Render the layout and insert into the DOM.
      layout.render().view.$el.appendTo('#main')
      
      # Cache the refererence.
      return @layout = layout
      
      # Newwer implimentation that I don't like
      
      # Create a new Layout with options.
      # layout = new Backbone.Layout(_.extend(
      #         el: "body"
      #       , options))
      
      # Cache the refererence.
      # return @layout = layout
      
  , Backbone.Events

