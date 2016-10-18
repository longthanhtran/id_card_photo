require_relative '../lib/resizer.rb'

RSpec.describe 'ImageResizer lib' do
  it 'can set parameters properly' do
    resizer = ImageResizer.new
    resizer.swidth = 350
    resizer.sheight = 460
    resizer.width = 1450
    resizer.height = 1080

    expect(resizer.swidth).to eq(350)
    expect(resizer.sheight).to eq(460)
    expect(resizer.width).to eq(1450)
    expect(resizer.height).to eq(1080)
  end

  it 'can resize 2 images into one big 9x12 image' do
  end

  it 'has proper default space as 10' do
    resizer = ImageResizer.new
    expect(resizer.space).to eq(10)
  end

  it 'can initialize rmagick instance properly' do
    resizer = ImageResizer.new
    expected = Magick::Image
    img = resizer.create_image

    expect(img).to be_instance_of(expected)
  end

  it 'can merge two photos' do
    skip 'I need to think ...'
    portrait = Resizer.new
    portrait.create_image
  end
end
