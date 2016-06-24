# encoding: utf-8

class UserCardUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/user_card/#{model.id / 1000}"
  end

  def content_type_whitelist
    /image\//
  end
end
