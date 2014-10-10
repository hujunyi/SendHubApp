class SendHub.Views.Contact extends Backbone.View

  template: JST['contacts/contact']

  render: =>
    @$el.html(@template(model: @model))
    @

