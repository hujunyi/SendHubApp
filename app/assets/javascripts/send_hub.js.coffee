window.SendHub =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: -> 
    $.ajaxPrefilter (options, originalOptions, jqXHR)-> 
      options.crossDomain ={crossDomain: true}
      options.xhrFields ={withCredentials: true}
    proxiedSync = Backbone.sync
    Backbone.sync = (method, model, options)-> 
      options || (options = {})
      options.crossDomain = true if !options.crossDomain
      options.xhrFields = {withCredentials:true} if !options.xhrFields
      proxiedSync(method, model, options)

    new SendHub.Routers.Contacts()
    Backbone.history.start({pushState: true})

$(document).ready ->
  SendHub.initialize()
  
