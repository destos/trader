
define(["app", "backbone.io", "modules/Location"], function(app, Backbone, Location) {
  var Router;
  Router = Backbone.Router.extend({
    routes: {
      "": "index"
    },
    initialize: function() {
      Backbone.io.connect();
      return app.locations = new Location.Collection();
    },
    index: function() {
      var locationGrid;
      locationGrid = new Location.Views.Grid({
        collection: app.locations
      });
      app.useLayout({
        template: 'home'
      });
      app.layout.setViews({
        '.grid': locationGrid
      });
      return app.locations.fetch();
    }
  });
  return Router;
});
