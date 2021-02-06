class Artwork < ActiveRecord::Base
  belongs_to :artist
  belongs_to :collector
end
