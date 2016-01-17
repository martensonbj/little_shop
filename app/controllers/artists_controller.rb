class ArtistsController < ApplicationController
  def index
    @artists = User.artists.includes(:items)
  end

  def show
    @artist = User.artists.find(params[:id])
  end
end
