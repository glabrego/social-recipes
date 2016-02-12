# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  storage :file

  def public_id
    model.name
  end
end
