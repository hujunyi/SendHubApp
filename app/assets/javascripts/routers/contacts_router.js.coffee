class SendHub.Routers.Contacts extends Backbone.Router
  routes: 
    '': 'index'

  initialize: ->
    @collection = new SendHub.Collections.Contacts()
    @collection.fetch({reset: true})

  index: ->
    view = new SendHub.Views.ContactsIndex(collection:@collection)
    $('#container').html(view.render().el)
