class ArtistsController < ApplicationController

  get '/artists' do #index
    @artists = Artist.all 
    erb :'artists/index'
  end

  get '/artists/new' do #new form
    erb :'artists/new'
  end

  post '/artists' do #create
    artist = Artist.new(
      FirstName: params[:FirstName],
      LastName: params[:LastName],
      DOB: params[:DOB],
      origin: params[:origin]
    )
    artist.save
    redirect '/artists'
  end

  get '/artists/:id' do #show
    
  end

  get '/artists/:id/edit' do #edit form
    
  end

  post '/artists/:id' do #update
    
  end

  get '/artists/:id/delete' do #delete confirmation
    
  end

  post '/artists/:id/delete' do #delete
    
  end
  
end