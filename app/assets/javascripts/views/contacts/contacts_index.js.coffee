class SendHub.Views.ContactsIndex extends Backbone.View

  template: JST['contacts/index']

  events: 
    'click #contact-submit': 'addContact'
    'click #message-send':'sendMsg'

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
    $(el).on('click','button',(e)=>
      e.preventDefault()
      @resetTag()
      @$('#contact-name').val(contact.get('name'))
      @$('#contact-number').val(contact.get('number').substr(2,11))
      @model = contact
    )
    $(el).on('click','a',(e)=>
      e.preventDefault()
      @resetTag()
      @$('#receiver').text(contact.get('name'))
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
  resetTag: =>
    @$('#contact-name').val("")
    @$('#contact-number').val("")
    @$('#receiver').text("")
    @model = null

  sendMsg: (e)=>
    e.preventDefault()
    msg = @$('#msg-content').val()
    data = {"contacts": [@model.get('id_str')],"text": msg}
    console.log data
    $.ajax({
      type: "POST"
      url: "/messages"
      data: JSON.stringify(data)
      dataType: 'json'
      #postData: JSON.stringify(data)
      contentType: 'application/json'
      success: (response)->
        console.log response
    })

