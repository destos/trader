
define(["backbone.layoutmanager"], function() {
  var JST, app;
  app = {
    root: "/"
  };
  JST = window.JST = window.JST || {};
  Backbone.LayoutManager.configure({
    manage: true,
    prefix: "app/templates/",
    fetch: function(path) {
      var done;
      path = path + ".html";
      if (JST[path]) {
        return JST[path];
      }
      done = this.async();
      return $.get(app.root + path, function(contents) {
        return done(JST[path] = _.template(contents));
      });
    }
  });
  return _.extend(app, {
    module: function(additionalProps) {
      return _.extend({
        Views: {}
      }, additionalProps);
    },
    useLayout: function(options) {
      var layout;
      layout = new Backbone.Layout(_.extend({
        el: "body"
      }, options));
      return this.layout = layout;
    }
  }, Backbone.Events);
});
