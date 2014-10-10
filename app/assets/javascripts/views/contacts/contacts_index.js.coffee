class SendHub.Views.ContactsIndex extends Backbone.View

  template: JST['contacts/index']

  events: 
    'click #contact-add': 'addContact'
    'click #contact-update': 'updateContact'
    'click #message-send':'sendMsg'
    'click #back':'back'
    'keyup': 'resetBtns'

  initialize: ->
    @collection.on('reset',@render)
    @collection.on('change',@render)
    @collection.on('add',@render)

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
      @$('#contact-add').hide()
      @$('#contact-update').show()
      @$('#back').show()
      @resetTag()
      @$('#contact-name').val(contact.get('name'))
      @$('#contact-number').val(contact.get('number').substr(2,11))
      @model = contact
    )
    $(el).on('click','a',(e)=>
      e.preventDefault()
      @resetTag()
      @$('#receiver').text("To: "+contact.get('name'))
      @model = contact
    )
    @$('#contacts-list').append(el)
    
  addContact: (e)->
    e.preventDefault()
    @$('#contact-add').prop('disabled',true)
    name = @$('#contact-name').val()
    number = @$('#contact-number').val()
    @collection.create(
      {name: name, number: number},
      {
        wait: true
        success: (response)=>
          @$('#contact-add').prop('disabled',false)
          @alertMsg('Contact added successfullly!','alert-success')
        error: (error)=>
          @$('#contact-add').prop('disabled',false)
          @alertMsg('Contact added failure!','alert-warn')
 
      })
      

  updateContact: (e)->
    e.preventDefault()
    @$('#contact-update').prop('disabled': true)
    name = @$('#contact-name').val()
    number = @$('#contact-number').val()
    @model.set({name: name,number: number})
    @model.save(
      {
        wait:true
        success: (response)=>
          @$('#contact-update').prop('disabled': false)
          @alertMsg('Contact updated.','alert-success')
        error: (error)=>
          @$('#contact-update').prop('disabled': false)
          @alertMsg('Contact updated failure.','alert-warning')
      })

  resetTag: =>
    @$('#contact-name').val("")
    @$('#contact-number').val("")

  sendMsg: (e)=>
    e.preventDefault()
    if not @model
      alert 'Select a receiver'
      return 
    @$('#message-send').prop('disabled',true)
    msg = @$('#msg-content').val()
    data = {"contacts": [@model.get('id_str')],"text": msg}
    console.log data
    $.ajax({
      type: "POST"
      url: "/messages"
      data: JSON.stringify(data)
      dataType: 'json'
      contentType: 'application/json'
      success: (response)=>
        @$('#msg-content').val('')
        @$('#message-send').prop('disabled',false)
        @alertMsg('Message sent successfully!','alert-success')
      error: ()=>
        @$('#message-send').prop('disabled',false)
        @alertMsg('Message sent failutre.','alert-danger')
    })
  back: (e)=>
    e.preventDefault()
    @resetTag()
    @$('#contact-add').show()
    @$('#contact-update').hide()
    @$('#back').hide()

  resetBtns: =>
    if @$('#msg-content').val()
      @$('#message-send').prop('disabled',false)
    else
      @$('#message-send').prop('disabled',true)
    if @$('#contact-number').val() and @$('#contact-name').val()
      @$('#contact-add').prop('disabled',false)
    else
      @$('#contact-add').prop('disabled',true)

  alertMsg:(msg,klass) =>
    @$('#alert-msg').html(msg)
    @$('#alert-msg').addClass(klass)
    @$('#alert-msg').show()
    @$('#alert-msg').delay(5000).hide(400)



