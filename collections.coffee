@Tasks = Tasks = new Meteor.Collection "tasks"

Tasks.allow
  insert: (userId, doc) ->
    doc.author is userId
  update: (userId, doc, fields, modifier) ->
    doc.author is userId
  remove: (userId, doc) ->
    doc.author is userId

# -------------------------------------------

if Meteor.isServer
  Meteor.publish 'my-tasks', ->
    Tasks.find(author: @userId)

  Meteor.publish 'my-user', ->
    Meteor.users.find(_id: @userId, {fields: 'profile': 1})

if Meteor.isClient
  Deps.autorun ->
    Meteor.subscribe 'my-tasks'
    Meteor.subscribe 'my-user'