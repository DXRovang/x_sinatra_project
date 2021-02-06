class CreateArtworks < ActiveRecord::Migration
  def change
    create_table :artworks do |t|
      t.string  "name"
      t.string  "genre"
      t.string  "medium"
      t.integer "price"
      t.integer "date"
      t.integer "artist_id"
      t.integer "collector_id"
    end
  end
end
