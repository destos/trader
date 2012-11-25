Mongoose = require 'mongoose'

schema = Mongoose.Schema
  hint: 
    type: String
    required: true
  address: String
  location:
    type: [Number]
    required: true
    index: '2d'
  active:
    type: Boolean
    default: false
    

module.exports = (db)->
  db.model 'Location', schema