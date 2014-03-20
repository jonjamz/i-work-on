Router.configure
  autoRender: false
  notFoundTemplate: 'notFound'

Router.map ->

  @route "home",
    path: "/"
    template: 'content__loggedOut'
    layoutTemplate: 'layout__base'
    before: ->
      if Meteor.userId()
        @redirect "/dashboard"
        @stop()

  @route "dashboard",
    path: "/dashboard"
    template: 'content__loggedIn'
    layoutTemplate: 'layout__base'
    before: ->
      if !Meteor.userId()
        @redirect "/"
        @stop()