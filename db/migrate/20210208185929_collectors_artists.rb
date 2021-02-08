class CollectorsArtists < ActiveRecord::Migration
  def change
    create_table :collectors_artists do |t|
      t.integer "artist_id"
      t.integer "collector_id"
    end
  end
end
