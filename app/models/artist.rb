class Artist < ActiveRecord::Base
  has_many :artworks
  has_many :collectors, through: :artworks

  # def slug
  #   name.downcase.gsub(" ","-")
  # end

  # def self.find_by_slug(slug)
  #   Artist.all.find{|artist| artist.slug == slug}
  # end

end
