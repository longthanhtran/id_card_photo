require 'rmagick'

class ImageResizer
  attr_accessor :swidth, :sheight, :width, :height, :space

  def initialize
    @space   = 10
    @width   = 1450
    @height  = 1080
    @swidth  = 350
    @sheight = 460
  end

  def create_image
    @bg = Magick::Image.new @width, @height do
      self.background_color = 'white'
    end
  end

  def create_output_filename(photos)
    tmp = photos.map do |photo|
      photo.split('/').last.split('.').first
    end
    tmp[0] + '-' + tmp[1] + '-print.png'
  end

  def merge_two_images(photos)
    create_image
    photos.each_with_index do |photo, y|
      image = Magick::Image.read(photo).first

      image.resize!(@swidth, @sheight)
      image.border!(1, 1, 'rgb(0, 0, 0)')
      3.times do |x|
        @bg = @bg.composite(image,
                            x * @swidth + (x + 1) * @space,
                            y * @sheight + (y + 1) * @space,
                            Magick::OverCompositeOp)
      end
    end

    @bg.write(create_output_filename(photos).to_s)
    @bg.destroy!
  end
end
