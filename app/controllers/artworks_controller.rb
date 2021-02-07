class ArtworksController < ApplicationController

  get '/artworks' do #index
    @artworks = Artwork.all 
    erb :'artworks/index'
  end

  get '/artworks/new' do #new form
    if !logged_in?
      redirect '/login'
    else
      erb :'artworks/new'
    end
  end

  post '/artworks' do #create
    
    if Artist.find_by(name: params[:artist_id]) != nil
      artist = Artist.find_by(name: params[:artist_id])
      artwork = Artwork.new(
        name: params[:name], 
        medium: params[:medium], 
        genre: params[:genre], 
        price: params[:price], 
        date: params[:date], 
        artist_id: artist.id,
        user_id: current_user.id 
      )
      artwork.save
      redirect "/artworks"
    else
      redirect "/artworks/new"
    end
  end

  get '/artworks/:id' do #show
    
  end

  get '/artworks/:id/edit' do #edit form
    
  end

  post '/artworks/:id' do #update
    
  end

  get '/artworks/:id/delete' do #delete confirmation
    
  end

  post '/artworks/:id/delete' do #delete
    
  end
end