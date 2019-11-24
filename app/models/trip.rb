class Trip < ApplicationRecord
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
