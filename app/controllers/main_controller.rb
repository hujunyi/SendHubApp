class MainController < ApplicationController
  before_action :contacts_url, only: [:index,:create,:update]
  before_action :messages_url, only: :message


  def home
    session[:username] = params[:username]
    session[:apikey] = params[:apikey]
  end

  def login
  end
  def index
    req = Net::HTTP::Get.new(@uri.request_uri)
    response = @http.request(req)
    render json: response.body, status: response.code
  end

  def create
    req = Net::HTTP::Post.new(@uri.request_uri)
    data = {"name"=>params["name"],"number"=>params["number"]}.to_json
    req.body = data
    req["Content-Type"] = "application/json"
    response = @http.request(req)
    render json: response.body, status: response.code
  end

  def message
    req = Net::HTTP::Post.new(@uri.request_uri)
    data = {"contacts"=>params[:contacts],"text"=>params[:text]}.to_json
    req.body = data
    req["Content-Type"] = "application/json"
    response = @http.request(req)
    render json: response.body, status: response.code
  end

  def update
    req = Net::HTTP::Put.new("#{@uri.path}#{params[:id_str]}/?#{@uri.query}")
    data = {"name"=>params["name"],"number"=>params["number"],"id"=>params[:id_str]}.to_json
    req.body = data
    req["Content-Type"] = "application/json"
    response = @http.request(req)
    render json: response.body, status: response.code
  end

  private
  def contacts_url
    @uri = URI.parse("#{base_url}contacts#{credentials}")
    @http = Net::HTTP.new(@uri.host,@uri.port)
    @http.use_ssl = true
  end

  def messages_url
    @uri = URI.parse("#{base_url}messages#{credentials}")
    @http = Net::HTTP.new(@uri.host,@uri.port)
    @http.use_ssl = true
  end

end
