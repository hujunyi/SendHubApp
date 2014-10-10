class SendHub.Views.ContactsIndex extends Backbone.View

  template: JST['contacts/index']

  events: 
    submit: 'addContact'

  initialize: ->
    @collection.on('reset',@render)
    @collection.on('change',@render)

  render: =>
    @$el.html(@template())
    @collection.each(@appendContact)
    @

  appendContact: (contact)=>
    console.log contact
    view = new SendHub.Views.Contact(model: contact)
    el = view.render().el
    $(el).on('click',(e)=>
      e.preventDefault()
      @$('#contact-name').val(contact.get('name'))
      @$('#contact-number').val(contact.get('number').substr(2,11))
      @model = contact
    )
    @$('#contacts-list').append(el)
    
  addContact: (e)->
    e.preventDefault()
    name = @$('#contact-name').val()
    number = @$('#contact-number').val()
    if !@model?
      @collection.create(
        {name: name, number: number},
        {success: (response)->
          console.log response
         error: (error)->
           console.log error
        })
    else
      @model.set({name: name,number: number})
      @model.save()

