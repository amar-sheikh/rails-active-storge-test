class PhotosController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :resize_image, only: [:create]

  def create
    photo = Photo.new(photo_params)

    if photo.save
      render json: photo_to_hash(photo), status: 201
    else
      render json: photo.errors.full_messages, status: 400
    end
  end

  private

  def photo_to_hash(photo)
    {
      id: photo.id,
      caption: photo.caption,
      image: url_for(photo.image)
    }
  end

  def resize_image
    return unless photo_params[:image]

    path = photo_params[:image].tempfile.path
    image = MiniMagick::Image.new(path)
    image.resize("300x300!")
    image.write(path)
  end

  def photo_params
    params.permit(:caption, :image)
  end
end
