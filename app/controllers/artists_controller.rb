class ArtistsController < ApplicationController

  get '/artists' do #index
    @artists = Artist.all 
    erb :'artists/index'
  end

  get 'artists/new' do #new form
    
  end

  post 'artists' do #create
    
  end

  get 'artists/:id' do #show
    
  end

  get 'artists/:id/edit' do #edit form
    
  end

  post 'artists/:id' do #update
    
  end

  get 'artists/:id/delete' do #delete confirmation
    
  end

  post 'artists/:id/delete' do #delete
    
  end
  
end