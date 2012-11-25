
define(["handlebars", "backbone.layoutmanager"], function(Handlebars) {
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
      if (JST[path]) {
        return JST[path];
      }
      done = this.async();
      return $.get("" + app.root + path + ".hbs", function(contents) {
        return done(JST[path] = Handlebars.compile(contents));
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
      var layout, name;
      name = options.template;
      options.template = "layouts/" + options.template;
      if (this.layout && this.layout.options.template === options.template) {
        return this.layout;
      }
      if (this.layout) {
        this.layout.remove();
      }
      layout = new Backbone.Layout(_.extend({
        className: "layout " + name,
        id: "layout"
      }, options));
      layout.render().view.$el.appendTo('#main');
      return this.layout = layout;
    }
  }, Backbone.Events);
});
