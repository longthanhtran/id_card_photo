require_relative '../lib/filer.rb'

RSpec.describe 'Filer lib' do
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
    Dir = double()
    expect(Dir)
      .to receive(:[])
      .with('photos/*')
      .and_return(['photos/1.jpg', 'photos/2.png'])
    photo_dir = 'photos'

    expected = [photo_dir + '/1.jpg', photo_dir + '/2.png']

    expect(filer.get_photo_list(photo_dir)).to eq(expected)
  end
end
