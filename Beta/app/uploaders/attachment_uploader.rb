class AttachmentUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :fog
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  def size_range
    1..10.megabytes
  end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
   def extension_whitelist
     %w(jpg jpeg gif png pdf doc docx odt txt csv htm html xls xlsx mp4 mov m4v qt)
   end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  private

  def check_size!(new_file)
    size = new_file.size
    expected_size_range = size_range
    if expected_size_range.is_a?(::Range)
      if size < expected_size_range.min
        raise CarrierWave::IntegrityError, I18n.translate(:"errors.messages.min_size_error", :min_size => ApplicationController.helpers.number_to_human_size(expected_size_range.min))
      elsif size > expected_size_range.max
        raise CarrierWave::IntegrityError, I18n.translate(:"errors.messages.max_size_error", :max_size => ApplicationController.helpers.number_to_human_size(expected_size_range.max))
      end
    end
  end

end
