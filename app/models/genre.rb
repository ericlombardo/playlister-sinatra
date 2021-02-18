class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  def slug  # takes name, replaces ' ' with '-' 
    self.name.split(" ").join('-')
  end

  def self.find_by_slug(slug) # converts slug to original, finds instance
    genre = slug.split("-").join(' ')
    Genre.find_by(name: genre)
  end
end