require 'sinatra/base'  # required for flash messages
require 'rack-flash'    # required for flash messages

class SongsController < ApplicationController
  use Rack::Flash # allows flash messages
  get '/songs' do 
    @songs = Song.all
    erb :"songs/index" 
  end

  get '/songs/new' do
    @genres = Genre.all
    @artists = Artist.all

    erb :"songs/new"
  end

  get '/songs/:slug' do
    
    @song = Song.find_by_slug(params[:slug])
    erb :"songs/show"
  end

  post '/songs' do
    if artist = Artist.find_by(params[:artist])
      artist
    else
      artist = Artist.create(params[:artist])
    end
    
    song = artist.songs.create(params[:song])
    flash[:notice] = "Successfully created song." # sets flash message
    redirect "/songs/#{song.slug}"
  end

  get '/songs/:slug/edit' do
    @genres = Genre.all
    @song = Song.find_by_slug(params[:slug])
    erb :"songs/edit"
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])
    @song.artist.name = params[:artist][:name] if !params[:artist][:name].empty?
    @song.save

    flash[:notice] = "Successfully updated song."
    erb :"songs/show"
  end

end