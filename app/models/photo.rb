class Photo < ApplicationRecord
  has_one_attached :image

  after_create :rename_image

  VALID_IMAGE_TYPES = ['jpg', 'jpeg', 'png']

  validates :image, presence: true
  validates :caption, presence: true, length: {minimun: 1, maximum: 100}
  validate :valid_image_type

  private

  def valid_image_type
    if self.image.filename.extension.in? VALID_IMAGE_TYPES
      true
    else
      self.errors.add :image, "must be in jpg or png format"
    end
  end

  def rename_image
    self.image.filename = "#{self.id}.#{self.image.filename.extension}"
  end
end
