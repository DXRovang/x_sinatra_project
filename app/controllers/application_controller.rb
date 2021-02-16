require './config/environment'

class ApplicationController < Sinatra::Base
  # before_action :require_login
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "auth_demo_lv"
  end

  helpers do
    def logged_in?
      # evaluates if email value is truthy
      !!current_user
    end

    def login(email, password)
      collector = Collector.find_by(:email => email)
      if collector && collector.authenticate(password)
      # creates a new key in session and sets value to collector email
      # session[:email] = params[:email]
        session[:email] = collector.email
      else
        redirect '/login'
      end
    end

    def current_user
      @current_user ||= Collector.find_by(:email => session[:email]) if session[:email]
    end
     
    def logout!
      session.clear
    end

    def artworks_instance_varibles
      @name = params[:name] 
      @medium = params[:medium] 
      @genre = params[:genre] 
      @price = params[:price] 
      @date = params[:date] 
      @FirstName = params[:FirstName]
      @LastName = params[:LastName]
    end

    def artists_instance_varibles
      @FirstName = params[:artist][:FirstName]
      @LastName = params[:artist][:LastName]
      @DOB = params[:artist][:DOB] 
      @origin = params[:artist][:origin] 

      @name = params[:artwork][:name] 
      @medium = params[:artwork][:medium] 
      @genre = params[:artwork][:genre] 
      @price = params[:artwork][:price] 
      @date = params[:artwork][:date] 

      erb :'artists/new'
    end
  end

end
