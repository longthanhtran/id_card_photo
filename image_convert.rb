require 'thor'
require_relative 'lib/resizer'

class ImageConverter < Thor
  desc 'show_image_list', 'List all image from a dir'
  def show_image_list(folder)
    photos = Dir["#{folder}/*"]
    resizer = ImageResizer.new

    resizer.merge_two_images photos
    puts 'Done'
  end

  desc 'create_output_file', 'Create output filename'
  def create_output_file(folder)
    photos = Dir["#{folder}/*"]
    resizer = ImageResizer.new
    puts resizer.create_output_filename(photos).to_s
  end
end

ImageConverter.start(ARGV)
