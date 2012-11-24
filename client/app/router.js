
define(["app", "backbone.io"], function(app, Backbone) {
  var Router;
  Router = Backbone.Router.extend({
    routes: {
      "": "index"
    },
    initialize: function() {
      return Backbone.io.connect();
    },
    index: function() {
      return console.log('got here');
    }
  });
  return Router;
});
