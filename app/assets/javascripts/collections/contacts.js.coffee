class SendHub.Collections.Contacts extends Backbone.Collection
  model: SendHub.Models.Contact
  url: "/contacts"
  parse: (response)->
    response.objects
