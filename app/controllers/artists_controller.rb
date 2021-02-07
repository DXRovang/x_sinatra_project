class ArtistsController < ApplicationController

  get '/artists' do #index
    @artists = Artist.all 
    erb :'artists/index'
  end

  get '/artists/new' do #new form
    erb :'artists/new'
  end

  post '/artists' do #create
    artists = Artist.all

    artists.each do |artist|
      if artist.FirstName == params[:artist][:FirstName] && artist.LastName == params[:artist][:LastName]
        redirect '/artists/error'
      end
    end

    artist = Artist.new(
      FirstName: params[:artist][:FirstName],
      LastName: params[:artist][:LastName],
      DOB: params[:artist][:DOB],
      origin: params[:artist][:origin]
    )
    artist.save
    #creates new_art & saves it to artist
    #associates new_art with current_user
    params[:artist][:artworks].each do |art|  
      new_art = Artwork.new(art)
      new_art.artist = artist
      new_art.collector_id = current_user.id
      new_art.save
    end
    redirect "/artists/#{artist.id}"
  end

  get '/artists/error' do
    erb :'artists/error'
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
    if !logged_in?
      redirect '/login'
    else
      @artist = Artist.find_by_id(params[:id])
      erb :'artists/delete'
    end
  end

  post '/artists/:id/delete' do #destroy
    artist = Artist.find_by_id(params[:id])
    art = artist.artworks 
    art.each do |work|
      work.delete
    end
    artist.delete
    redirect to "/artists"
  end
  
end