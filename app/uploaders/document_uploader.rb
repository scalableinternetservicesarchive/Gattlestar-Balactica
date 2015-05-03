# encoding: utf-8

#
# In order for thumbnail generation to work you have to:
# Mac) Run
# `brew install imagemagick`
# `brew install ghostscript`
#
# Ubuntu) Run
# `sudo apt-get install imagemagick`
# `sudo apt-get install libmagickwand-dev`
#

class DocumentUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  def cover
    manipulate! do |frame, index|
      frame if index.zero?
    end
  end

  # Create different versions of your uploaded files:
  # You can access the thumbnail files by doing Document.find(thumb_id).document.thumb.url
  # Strangely even documents that can't be thumbnailed show a url even though the thumbnail wasn't created
  # I guess to check for it you have to check if image opening failed or not
  version :thumb, :if => :is_thumbnable? do
    process :cover
    process :resize_to_fill => [1000, 1000, Magick::NorthGravity]
    process :convert => 'png'

    def full_filename (for_file = model.source.file)
      super.chomp(File.extname(super)) + '.png'
    end
  end

  # Only generate thumbnails for pdf and image files
  def is_thumbnable?(new_file)
    return model.is_thumbnable unless model.is_thumbnable.nil?
    model.is_thumbnable = \
      begin
        new_file.content_type.start_with? 'image' or new_file.content_type == 'application/pdf'
      end
    return model.is_thumbnable
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
   def extension_white_list
     %w(jpg jpeg gif png pdf doc docx txt)
   end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
