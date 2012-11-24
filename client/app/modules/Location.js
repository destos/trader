
define(["app"], function(app) {
  var Location;
  Location = app.module();
  Location.Model = Backbone.Model.extend({});
  Location.Collection = Backbone.Collection.extend({
    model: Location.Model
  });
  Location.Views.Layout = Backbone.Layout.extend({
    template: "Location"
  });
  return Location;
});
