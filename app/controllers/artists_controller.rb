class ArtistsController < ApplicationController
  def index
    @artists = Artist.all.includes(:items)
  end
end
