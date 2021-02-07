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
    @artist = Artist.find_by_id(params[:id])
    erb :'artists/show'
  end

  get '/artists/:id/edit' do #edit form
    if !logged_in?
      redirect '/login'
    else
      @artist = Artist.find_by_id(params[:id])
      erb :'artists/edit'
    end
  end

  post '/artists/:id' do #update
    artist = Artist.find_by_id(params[:id])

    artist.update(
      FirstName: params[:FirstName],
      LastName: params[:LastName],
      origin: params[:origin],
      DOB: params[:DOB]
    )
    redirect to "/artists/#{artist.id}"
  end

  get '/artists/:id/delete' do #delete confirmation
    
  end

  post '/artists/:id/delete' do #delete
    
  end
  
end