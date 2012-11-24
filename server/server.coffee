express = require("express")
http = require('http')
backboneio = require("backbone.io")
path = require('path')
sessions = new express.session.MemoryStore()

app = express()
server = http.createServer(app)
app.use express.cookieParser()
app.use express.session(
  secret: "mysecret"
  store: sessions
)

app.use express.static( path.resolve __dirname, '..', 'client')

app.get "/login", (req, res) ->
  req.session.user = "myuser"
  res.redirect "/"

app.get "/logout", (req, res) ->
  req.session.user = `undefined`
  res.redirect "/"

server.listen 3000
console.log "http://localhost:3000/"

auth = (req, res, next) ->
  unless req.session.user
    next new Error("Unauthorized")
  else
    next()

messages = backboneio.createBackend()
messages.use backboneio.middleware.cookieParser()
messages.use backboneio.middleware.session(store: sessions)
messages.use "create", "update", "delete", auth
messages.use backboneio.middleware.memoryStore()

backboneio.listen server,
  messages: messages
