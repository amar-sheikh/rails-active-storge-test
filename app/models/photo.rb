class Photo < ApplicationRecord
  has_one_attached :image

  after_create :rename_image

  VALID_IMAGE_TYPES = ['jpg', 'jpeg', 'png']

  validates :image, presence: true
  validates :caption, presence: true, length: {minimun: 1, maximum: 100}
  validate :valid_image_type, :valid_image_size

  private

  def valid_image_type
    if self.image.filename.extension.in? VALID_IMAGE_TYPES
      true
    else
      self.errors.add :image, "must be in jpg or png format"
    end
  end

  def valid_image_size
    if self.image.byte_size < 200_000
      true
    else
      self.errors.add :image, "size should be less than 200kb"
    end
  end

  def rename_image
    self.image.filename = "#{self.id}.#{self.image.filename.extension}"
  end
end
