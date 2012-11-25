express = require("express")
http = require('http')
backboneio = require("backbone.io")
path = require('path')
eyes = require('eyes')

SessionStore = require("session-mongoose")(express)
app = express()
server = http.createServer(app)

sessions = new SessionStore({
    url: "mongodb://localhost/session",
    interval: 120000 # expiration check worker run interval in millisec (default: 60000)
});

sessionSecret = "mysecret"
app.use express.cookieParser()
app.use express.session(
  secret: sessionSecret 
  store: sessions
)

# Serve client directory for testing
app.use express.static( path.resolve __dirname, '..', 'client')
# app.use express.static( path.resolve __dirname, '..', 'client/dist/debug')

app.get "/login", (req, res) ->
  req.session.user = "myuser"
  res.redirect "/"

app.get "/logout", (req, res) ->
  req.session.user = undefined
  res.redirect "/"

server.listen 3000

auth = (req, res, next) ->
  eyes req
  unless req.session.user
    next new Error("Unauthorized")
  else
    next()

mongoose = require('mongoose');

db = mongoose.createConnection('localhost', 'trader')
Location = require('./models/location')(db)

locations = backboneio.createBackend()
# locations.use backboneio.middleware.cookieParser()
# locations.use backboneio.middleware.session
#   store: sessions
#   secret: sessionSecret
#   
# locations.use "create", "update", "delete", auth
locations.use backboneio.middleware.mongooseStore(Location)

backboneio.listen server,
  locations: locations
