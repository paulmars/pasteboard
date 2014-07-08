class SitefileUploader < CarrierWave::Uploader::Base

  include CarrierWave::MimeTypes
  process :set_content_type

  storage :fog

  def filename
    "#{model.stub}#{model.extension}"
  end

  def store_dir
    "images/#{model.board.stub}"
  end

end
