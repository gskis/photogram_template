require 'open-uri'
class Trip < ApplicationRecord
  before_validation :geocode_city_visited

  def geocode_city_visited
    if self.city_visited.present?
      url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{URI.encode(self.city_visited)}"

      raw_data = open(url).read

      parsed_data = JSON.parse(raw_data)

      if parsed_data["results"].present?
        self.city_visited_latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

        self.city_visited_longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

        self.city_visited_formatted_address = parsed_data["results"][0]["formatted_address"]
      end
    end
  end
  mount_uploader :image, ImageUploader

  # Direct associations

  has_many   :comments,
             :dependent => :destroy

  has_many   :likes,
             :foreign_key => "photo_id",
             :dependent => :destroy

  belongs_to :owner,
             :class_name => "User",
             :counter_cache => :own_photos_count

  # Indirect associations

  has_many   :fans,
             :through => :likes,
             :source => :user

  has_many   :followers,
             :through => :owner,
             :source => :following

  has_many   :fan_followers,
             :through => :fans,
             :source => :following

  # Validations

  validates :image, :presence => true

  validates :owner_id, :presence => true

end
