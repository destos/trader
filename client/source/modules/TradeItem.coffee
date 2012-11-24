# Tradeitem module

# Application.

# Map dependencies from above array.
define ["app"], (app) ->
  
  # Create a new module.
  Tradeitem = app.module()
  
  # Default Model.
  Tradeitem.Model = Backbone.Model.extend({})
  
  # Default Collection.
  Tradeitem.Collection = Backbone.Collection.extend(model: Tradeitem.Model)
  
  # Default View.
  Tradeitem.Views.Layout = Backbone.Layout.extend(template: "tradeitem")
  
  # Return the module for AMD compliance.
  return Tradeitem

