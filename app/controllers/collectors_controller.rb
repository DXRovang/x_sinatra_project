class CollectorsController < ApplicationController
  
  get '/signup' do 
    erb :"/collectors/new"
  end
  
  post '/collectors' do
    @name = params[:name]
    @email = params[:email]
    @password = params[:password]
    if params[:name] == "" || params[:email] == "" || params[:password] == ""
      @error = "-You must fill in all fields-"
      erb :"/collectors/new"
    elsif Collector.find_by(name: params[:name])
      redirect "/collectors/errors/username"
    elsif Collector.find_by(email: params[:email])
      redirect "/collectors/errors/email"
    else
      @collector = Collector.new(
        name: params[:name],
        email: params[:email],
        password: params[:password]
      )
      if @collector.save
        redirect '/login'
      else
        erb :"/collectors/new"
      end
    end
  end

  get "/index" do #index
    if !logged_in? 
      redirect '/login'
    else
      erb :'collectors/index'
    end
  end

  get '/collectors' do #show
    if !logged_in? 
      redirect '/login'
    else
      erb :'collectors/show'
    end
  end

  get '/collectors/show_artists' do
    if !logged_in? 
      redirect '/login'
    else
      erb :'collectors/show_artists'
    end
  end

  get '/collectors/edit' do #edit
    if !logged_in?
      redirect '/login'
    else
      erb :'collectors/edit'
    end
  end

  patch '/collectors/edit' do #update
    if !logged_in?
      redirect '/login'
    else
      current_user.update(
        name: params[:name],
        email: params[:email],
        password: params[:password]
      )
      redirect to "/collectors"
    end
  end

  get '/collectors/delete' do #delete confirmation
    if !logged_in?
      redirect '/login'
    else
      erb :'collectors/delete'
    end
  end

  delete '/collectors/delete' do #delete
    if !logged_in?
      redirect '/login'
    else
      current_user.artworks.each do |art|
        art.delete
      end
      current_user.delete
      redirect to "/signup"
    end
  end
  
  get "/collectors/errors/username" do
    erb :"collectors/errors/username"
  end

  get "/collectors/errors/email" do
    erb :"collectors/errors/email"
  end

end