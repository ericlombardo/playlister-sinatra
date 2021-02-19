class Song < ActiveRecord::Base 
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug  # takes name, replaces ' ' with '-', sets with downcase 
    self.name.split(" ").join('-').downcase
  end

  def self.find_by_slug(slug) # compares Song instances as slug with params slug
    Song.all.find do |s|
      s.slug == slug
    end
  end
end