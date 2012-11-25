# Location module
# display trading locations as well as information about public items
# stored at those locations
define ["app"], (app) ->
  
  # Create a new module.
  Location = app.module()
  
  
  # Default Model.
  Location.Model = Backbone.Model.extend
    
    # backend: 'locations'
    
    defaults:
      location: [0, 0]
      hint: 'Inside the store, around on the right side of the entrance.'
      address: '1234 Some road City, State 12345'
      items: []
      prev_items: []
      type: []
      active: false
    
    initialize: (options) ->
    
    itemCount: ->
      return @get('items').length
      
    serialize: ->
      _.extend(@toJSON(),
        item_count: itemCount()
      )
  
  
  # Default Collection.
  Location.Collection = Backbone.Collection.extend
    model: Location.Model
    
    backend:
        name: 'locations'
        channel: 'locals'
    
    initialize: (options) ->
      @bindBackend()
      
      # @on 'backend:create', (model) =>
      #   @add(model)
      # @on 'backend:update', (model) =>
      #   @get(model.id).set(model)
      # @on 'backend:delete', (model) =>
      #   @remove(model.id)
  
  
  Location.Views.GridItem = Backbone.View.extend
    
    tagName: 'li'
    
    template: "locations/gridItem"
    
    initialize: () ->
      _.bindAll(@, 'render', 'remove')
      
      @model.on 'change', @render
      @model.on 'destroy', @remove
    
    serialize: () ->
      return {
        location: @model.toJSON()
        display_address: true
      }
  
  
  # Default View.
  Location.Views.Grid = Backbone.View.extend
    
    template: "locations/grid"
    
    initialize: () ->
      _.bindAll(@, 'render')
      
      # @collection.bind('add', @render)
      @collection.bind('reset', @render)
      @collection.bind('change', @render)
      # @collection.bind('all', @render)
      return
      
    beforeRender: () ->
      if @collection.length
        @collection.each (location) =>
          @insertView '.location-grid', new Location.Views.GridItem
            model: location
  
  
  # Return the module for AMD compliance.
  return Location

