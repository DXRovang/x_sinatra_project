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

  get 'collectors/:id' do #show
    
  end

  get 'collectors/:id/edit' do #edit form
    
  end

  post 'collectors/:id' do #update
    
  end

  get 'collectors/:id/delete' do #delete confirmation
    
  end

  post 'collectors/:id/delete' do #delete
    
  end

end