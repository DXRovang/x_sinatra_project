class Artwork < ActiveRecord::Base
  belongs_to :artist
  belongs_to :collector

  # def slug
  #   name.downcase.gsub(" ","-")
  # end

  # def self.find_by_slug(slug)
  #   Artwork.all.find{|artwork| artwork.slug == slug}
  # end
end
