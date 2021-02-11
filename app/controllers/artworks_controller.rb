class ArtworksController < ApplicationController
  
  get '/artworks' do #index
    if !logged_in?
      redirect '/login'
    else
      @artworks = Artwork.all 
      erb :'artworks/index'
    end
  end

  get '/artworks/new' do #new form
    if !logged_in?
      redirect '/login'
    else
      erb :'artworks/new'
    end
  end

  post '/artworks' do #create
    if !logged_in?
      redirect '/login'
    else
      if params[:name] == "" || params[:LastName] == ""
        redirect "/artworks/new"
      else
        if Artist.find_by(LastName: params[:LastName]) != nil && Artist.find_by(LastName: params[:LastName])
          artist = Artist.find_by(LastName: params[:LastName])
          artwork = Artwork.new(
            name: params[:name], 
            medium: params[:medium], 
            genre: params[:genre], 
            price: params[:price], 
            date: params[:date], 
            artist_id: artist.id,
            collector_id: current_user.id 
          )
          artwork.save
          redirect "/artworks"
        else
          redirect "/artworks/new"
        end
      end
    end 
  end

  get '/artworks/:id' do #show
    if !logged_in?
      redirect '/login'
    else
      @artwork = Artwork.find(params[:id])
      erb :'artworks/show'
    end
  end

  get '/artworks/:id/edit' do #edit form
    if !logged_in?
      redirect '/login'
    else
      @artwork = Artwork.find_by_id(params[:id])
      erb :'artworks/edit'
    end
  end

  patch '/artworks/:id' do #update
    if !logged_in?
      redirect '/login'
    else 
      artwork = Artwork.find_by_id(params[:id])
      
      if artwork.collector == current_user
        artwork.update(
          name: params[:name],
          genre: params[:genre],
          medium: params[:medium],
          date: params[:date],
        )
        redirect to "/artworks/#{artwork.id}"
      else
        redirect to "/artworks/error" 
      end
    end
  end

  get '/artworks/:id/delete' do #delete confirmation
    if !logged_in?
      redirect '/login'
    else
      @artwork = Artwork.find_by_id(params[:id])
      erb :'artworks/delete'
    end
  end

  delete '/artworks/:id/delete' do #delete
    if !logged_in?
      redirect '/login'
    else
      artwork = Artwork.find_by_id(params[:id])

      if artwork.collector == current_user
        artwork.delete
        redirect to "/artworks"
      else
        redirect to "/artworks/error" 
      end
    end
  end

end