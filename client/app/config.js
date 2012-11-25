
require.config({
  deps: ["../vendor/jam/require.config", "main"],
  paths: {
    "socket.io": "/socket.io/socket.io",
    "backbone.io": "/socket.io/backbone.io"
  },
  shim: {
    "backbone.io": {
      deps: ["backbone", "socket.io"],
      exports: "Backbone"
    }
  }
});
