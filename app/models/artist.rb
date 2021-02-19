class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def slug  # takes name, replaces ' ' with '-', sets to downcase
    self.name.split(" ").join('-').downcase
  end

  def self.find_by_slug(slug) # compares Artist instances as slug with params slug
    Artist.all.find do |s|
      s.slug == slug
    end
  end
end