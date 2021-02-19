class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  def slug  # takes name, replaces ' ' with '-', sets with downcase 
    self.name.split(" ").join('-').downcase
  end

  def self.find_by_slug(slug) # compares Genre instances as slug with params slug
    Genre.all.find do |s|
      s.slug == slug
    end
  end
end