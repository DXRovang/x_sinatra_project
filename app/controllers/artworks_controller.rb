class ArtworksController < ApplicationController

  get '/artworks' do #index
    @artworks = Artwork.all 
    erb :'artworks/index'
  end

  get '/artworks/new' do #new form
    
  end

  post '/artworks' do #create
    
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