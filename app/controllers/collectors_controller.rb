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

  get "/index" do
    if !logged_in? 
      redirect '/login'
    else
      erb :'collectors/index'
    end
  end

end