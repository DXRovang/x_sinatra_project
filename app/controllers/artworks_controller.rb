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

    @name = params[:name] 
    @medium = params[:medium] 
    @genre = params[:genre] 
    @price = params[:price] 
    @date = params[:date] 
    @FirstName = params[:FirstName]
    @LastName = params[:LastName]

    if !logged_in?
      redirect '/login'
    else
      if params[:name] == ""
        @error = "I'm sorry, you must name an Artwork to enter it in the Database."
        erb :'artworks/new'
      elsif params[:LastName] == ""
        @error = "I'm sorry, you must enter the name of an Artist to add an Artwork to the Database.
        "
        erb :'artworks/new'
      elsif params[:date] == nil || params[:date] == ""
        @error = "I'm sorry, you must enter a date for this Artwork."
        erb :'artworks/new'
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
          @error = "I'm sorry, you must enter the name of an existing Artist to add an artwork to the Database.
          "
          erb :'artworks/new'
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
        redirect to "/artworks/errors/permission" 
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
        redirect to "/artworks/errors/permission" 
      end
    end
  end

  get '/artworks/errors/empty' do
    erb :'artworks/errors/empty'
  end 

  get '/artworks/errors/artist' do
    erb :'artworks/errors/artist'
  end 

  get '/artworks/errors/exists' do
    erb :'artworks/errors/exists'
  end 

  get '/artworks/errors/date' do
    erb :'artworks/errors/date'
  end 

  get '/artworks/errors/permission' do
    erb :'artworks/errors/permission'
  end

end