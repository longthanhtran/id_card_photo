#!/usr/bin/env ruby

# require 'rubygems'
require 'RMagick'

# merge array of two photos into a  9x12cm photo with 8 3x4cm identity photos

class PhotoEditor
  def initialize
    @bg = Magick::Image.new(@width, @height) do
      self.background_color = 'white'
    end
  end

  def set_width_heigth
    @swidth  = 350
    @sheight = 460

    @width   = 1450
    @height  = 1080
    @space   = 10
  end

  def merge_two_photos(photos)
    y = 0

    photos.each do |input|
      image = Magick::Image.read(input).first

      image.resize!(@swidth, @sheight)
      image.border!(1, 1, 'rgb(0,0,0)')
      (0..3).each_with_index do |image, index|
        @bg =  @bg.composite(image,
              image * @swidth + (image + 1) * @space,
              index * @sheight + (index + 1) * @space,
              Magick::OverCompositeOp)
      end
    end

    # Add -print to image basename, write to file.
    out = ''
    photos.each do |fn|
      out << fn.sub(/.*\//, '').sub(/\..*/, '')
      out << '-'
    end

    out << 'print.jpg'
    puts "Writing #{out}"
    @bg.write(out)
  end
end

unless ARGV[0]
  puts 'Usage: hinhthe.rb path-to-input-images pat'
  exit
end
args         = ARGV

arr          = Array.new
arrtmp       = Array.new
odd          = true
current_path = ''

Dir["#{args[0]}/*"].each do |path|
  current_path = path
  if odd
    arrtmp = [path]
  else
    arrtmp << path
    arr << arrtmp
  end
  odd = !odd
end

unless odd
  arrtmp << current_path
  arr << arrtmp
end

p arr

arr.each do |item|
  merge_two_photos(item)
end
