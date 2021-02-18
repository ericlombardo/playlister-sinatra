class Song < ActiveRecord::Base 
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug  # takes name, replaces ' ' with '-' 
    self.name.split(" ").join('-')
  end

  def self.find_by_slug(slug) # converts slug to original, finds instance
    song_name = slug.split("-").join(' ')
    Song.find_by(name: song_name)
  end
end