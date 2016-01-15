class ArtistsController < ApplicationController
  def index
    @artists = User.artists
  end
end
