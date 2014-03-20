Template['content__loggedIn'].helpers
  tasks: ->
    Tasks.find(completed: false).fetch()

Template['taskForm'].helpers
  lastUsedTags: ->
    if Meteor.user()?.profile?.lastUsedTags?
      Meteor.user().profile.lastUsedTags

# ------------------------------------------------------------

Template['content__loggedIn'].events
  'click .complete': (e, t) ->
    Tasks.update @_id, $set: completed: true

  'click .delete': (e, t) ->
    Tasks.remove @_id

Template['taskForm'].events
  'submit form': (e, t) ->
    e.preventDefault()

    # Prevent more than 3 tasks at once
    if Tasks.find(completed: false).count() is 3
      alert "Maximum 3 tasks at a time!"
      return undefined

    title = t.find('#task-input').value
    tags = $(t.find "[name='tags-input']").siblings(".tagsinput").children(".tag")
    tagList = [];

    for tag, i in tags
      tagList.push $(tags[i]).text().substring(0, $(tags[i]).text().length -  1).trim()

    # Save last used tags for convenience
    Meteor.users.update Meteor.userId(), $set: profile: lastUsedTags: tagList

    # Save task
    Tasks.insert
      author: Meteor.userId()
      title: title
      tags: tagList
      completed: false
      date: new Date()

# ------------------------------------------------------------

Template['taskForm'].rendered = ->
  $('#tags-input').tagsInput()