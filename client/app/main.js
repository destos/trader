
define(["app", "router"], function(app, Router) {
  app.router = new Router();
  Backbone.history.start({
    pushState: true,
    root: app.root
  });
  return $(document).on("click", "a[href]:not([data-bypass])", function(evt) {
    var href, root;
    href = {
      prop: $(this).prop("href"),
      attr: $(this).attr("href")
    };
    root = location.protocol + "//" + location.host + app.root;
    if (href.prop.slice(0, root.length) === root) {
      evt.preventDefault();
      return Backbone.history.navigate(href.attr, true);
    }
  });
});
