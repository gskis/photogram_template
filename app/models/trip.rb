class Trip < ApplicationRecord
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

  # Validations

  validates :image, :presence => true

  validates :owner_id, :presence => true

end
