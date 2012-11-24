# Location module

# Application.

# Map dependencies from above array.
define ["app"], (app) ->
  
  # Create a new module.
  Location = app.module()
  
  # Default Model.
  Location.Model = Backbone.Model.extend({})
  
  # Default Collection.
  Location.Collection = Backbone.Collection.extend(model: Location.Model)
  
  # Default View.
  Location.Views.Layout = Backbone.Layout.extend(template: "Location")
  
  # Return the module for AMD compliance.
  return Location

