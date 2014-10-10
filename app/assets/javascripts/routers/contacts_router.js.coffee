class SendHub.Routers.Contacts extends Backbone.Router
  routes: 
    'home': 'index'

  initialize: ->
    @collection = new SendHub.Collections.Contacts()

  index: ->
    view = new SendHub.Views.ContactsIndex(collection:@collection)
    $('#container').html(view.render().el)
