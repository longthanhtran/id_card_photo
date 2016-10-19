require 'pp'
require 'ap'
require 'fakefs/spec_helpers'
require_relative '../lib/filer.rb'

RSpec.describe 'Filer lib' do
  include FakeFS::SpecHelpers

  it 'can init object properly' do
    filer = Filer.new
    expect(filer).to be_instance_of(Filer)
  end

  it 'can receive array of file and return array of filename only' do
    expected = ['1.jpg', '2.png', '3.png']
    arr_file = [
      'photos/1.jpg',
      'photos/2.png',
      'photos/3.png'
    ]

    filer = Filer.new
    result = filer.to_file_array(arr_file)

    expect(result).to eq(expected)
  end

  it 'get list of photo files' do
    filer = Filer.new
    photo_dir = '/photos/'

    Dir.mkdir(photo_dir)
    2.times do |photo|
      FileUtils.touch(photo_dir + photo.to_s + '.jpg')
    end

    expected = ['/photos/0.jpg', '/photos/1.jpg']
    result = filer.get_photo_list(photo_dir)

    expect(result).to eq(expected)
  end
end
