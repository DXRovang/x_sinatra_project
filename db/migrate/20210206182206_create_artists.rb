class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string  "FirstName"
      t.string  "LastName"
      t.string  "DOB"
      t.string  "origin"
    end
  end
end
