
SendHubApp
====

This is the coding task from SendHub. This app uses it's APIs to implement adding contacts, editing contacts and send message.
I used backbone.js as front-end framework(written in coffeescript) and Rails as a proxy server(to get around CROS issue).

Environments
-
* ruby 2.1
* Rails 4.1.2

How to use
-
Before run this app, you have to set your USERNAME and APIKey in the app/controllers/application_controller.rb
```
  def credentials(number=USERNAME,api_key=APIKey)
    "/?username=#{number}&api_key=#{api_key}"
  end
```
```
bundle 
rails s
```
go to http://localhost:3000 in your browser

[Online Link](http://sendapp.joeyhu.info/)(There is some issues with the live one on heroku, I will fix it tomorrow morning.)



