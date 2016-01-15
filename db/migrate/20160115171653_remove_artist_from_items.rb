class RemoveArtistFromItems < ActiveRecord::Migration
  def change
    remove_reference :items, :artist, index: true, foreign_key: true
  end
end
