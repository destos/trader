
define(["app"], function(app) {
  var Tradeitem;
  Tradeitem = app.module();
  Tradeitem.Model = Backbone.Model.extend({});
  Tradeitem.Collection = Backbone.Collection.extend({
    model: Tradeitem.Model
  });
  Tradeitem.Views.Layout = Backbone.Layout.extend({
    template: "tradeitem"
  });
  return Tradeitem;
});
