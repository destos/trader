
define(["app"], function(app) {
  var Location;
  Location = app.module();
  Location.Model = Backbone.Model.extend({
    idAttribute: '_id',
    defaults: {
      location: [0, 0],
      hint: 'Inside the store, around on the right side of the entrance.',
      address: '1234 Some road City, State 12345',
      items: [],
      prev_items: [],
      type: [],
      active: false
    },
    initialize: function(options) {},
    itemCount: function() {
      return this.get('items').length;
    },
    serialize: function() {
      return _.extend(this.toJSON(), {
        item_count: itemCount()
      });
    }
  });
  Location.Collection = Backbone.Collection.extend({
    model: Location.Model,
    backend: {
      name: 'locations',
      channel: 'locals'
    },
    initialize: function(options) {
      return this.bindBackend();
    }
  });
  Location.Views.GridItem = Backbone.View.extend({
    tagName: 'li',
    template: "locations/gridItem",
    initialize: function() {
      _.bindAll(this, 'render', 'remove');
      this.model.on('change', this.render);
      return this.model.on('destroy', this.remove);
    },
    serialize: function() {
      return {
        location: this.model.toJSON(),
        display_address: true
      };
    }
  });
  Location.Views.Grid = Backbone.View.extend({
    template: "locations/grid",
    initialize: function() {
      _.bindAll(this, 'render');
      this.collection.bind('reset', this.render);
      this.collection.bind('change', this.render);
    },
    beforeRender: function() {
      var _this = this;
      if (this.collection.length) {
        return this.collection.each(function(location) {
          return _this.insertView('.location-grid', new Location.Views.GridItem({
            model: location
          }));
        });
      }
    }
  });
  return Location;
});
