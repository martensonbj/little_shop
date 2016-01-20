class ArtistsController < ApplicationController
  def index
    @artists = User.artists.includes(:items)
  end

  def show
    @artist = User.artists.includes(:items).find_by_slug(params[:slug])
  end
end
