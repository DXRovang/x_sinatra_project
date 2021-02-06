require './config/environment'

class ApplicationController < Sinatra::Base

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
  end

end
