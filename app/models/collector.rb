class Collector < ActiveRecord::Base
  has_secure_password
  has_many :artworks
  has_many :artists, through: :artworks
end
