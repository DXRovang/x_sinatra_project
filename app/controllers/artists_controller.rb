class ArtistsController < ApplicationController

  get '/artists' do #index
    if !logged_in?
      redirect '/login'
    else
      @artists = Artist.all 
      erb :'artists/index'
    end
  end

  get '/artists/new' do #new form
    if !logged_in?
      redirect '/login'
    else
      erb :'artists/new'
    end
  end

  post '/artists' do #create
    if !logged_in?
      redirect '/login'
    else
      artists = Artist.all
      if params[:artist][:FirstName] == "" && params[:artist][:LastName] == "" 
        @error = "I'm sorry, you must enter a name to create an Artist profile."
        artists_instance_varibles
      else
        artists.each do |artist|
          if artist.FirstName == params[:artist][:FirstName] && artist.LastName == params[:artist][:LastName]
            @error = "I'm sorry, this Artist already exists in the Database."
            artists_instance_varibles
          end
        end
        artist = Artist.new(
          FirstName: params[:artist][:FirstName],
          LastName: params[:artist][:LastName],
          DOB: params[:artist][:DOB],
          origin: params[:artist][:origin]
        )
        #creates new_art & saves it to artist;associates new_art with current_user
        if params[:artwork][:name] == ""
          @error = "I'm sorry, you must enter the name of an Artwork to add an Artist to the Database.
          "
          artists_instance_varibles
        elsif params[:artwork][:date] == nil || params[:artwork][:date] == ""
          @error = "I'm sorry, you must enter a date for this Artwork."  
          artists_instance_varibles
        else
          artist.save
          new_art = Artwork.new(
            name: params[:artwork][:name],
            date: params[:artwork][:date],
            genre: params[:artwork][:genre],
            medium: params[:artwork][:medium],
            price: params[:artwork][:price]
          )
          new_art.artist = artist
          new_art.collector_id = current_user.id
          new_art.save
          redirect "/artists/#{artist.id}"
        end
      end
    end 
  end

  get '/artists/:id' do #show
    if !logged_in?
      redirect '/login'
    else
      @artist = Artist.find_by_id(params[:id])
      erb :'artists/show'
    end
  end

  get '/artists/:id/edit' do #edit form
    if !logged_in?
      redirect '/login'
    else
      @artist = Artist.find_by_id(params[:id])
      erb :'artists/edit'
    end
  end

  patch '/artists/:id' do #update
    if !logged_in?
      redirect '/login'
    else
      artist = Artist.find_by_id(params[:id])

      if artist.collectors.include?(current_user)
        artist.update(
          FirstName: params[:FirstName],
          LastName: params[:LastName],
          origin: params[:origin],
          DOB: params[:DOB]
        )
        redirect to "/artists/#{artist.id}"
      else
        redirect to "/artworks/errors/permission"
      end
    end
  end

  get '/artists/:id/delete' do #delete confirmation
    if !logged_in?
      redirect '/login'
    else
      @artist = Artist.find_by_id(params[:id])
      erb :'artists/delete'
    end
  end

  delete '/artists/:id/delete' do #destroy
    if !logged_in?
      redirect '/login'
    else
      artist = Artist.find_by_id(params[:id])
      if artist.artworks == []
        artist.delete
      else
        redirect to '/artists/errors/permission' 
      end
      redirect to "/artists"
    end
  end

  get '/artists/errors/permission' do
    erb :'artists/errors/permission'
  end

end

