# Set the require.js configuration for your application.
require.config
  
  # Initialize the application with the main application file and the JamJS
  # generated configuration file.
  deps: ["../vendor/jam/require.config", "main"]
  
  # Put paths here.
  paths: {
    "socket.io": "/socket.io/socket.io"
    "backbone.io": "/socket.io/backbone.io"
  }
  
  # Put shims here.
  shim: {
    "backbone.io":{
      deps: ["backbone", "socket.io"]
      exports: "Backbone"
    }
  }
