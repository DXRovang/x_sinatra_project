class CollectorsController < ApplicationController
  
  get '/signup' do 
    erb :"/collectors/new"
  end
  
  post '/collectors' do
    @collector = Collector.new
    @collector.name = params[:name]
    @collector.email = params[:email]
    @collector.password = params[:password]
    if @collector.save
      redirect '/login'
    else
      erb :"/collectors/new"
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

  get '/collectors/edit' do #edit form
    
  end

  post '/collectors' do #update
    
  end

  get '/collectors/delete' do #delete confirmation
    
  end

  post '/collectors/delete' do #delete
    
  end

end