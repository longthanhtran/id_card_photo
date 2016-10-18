class Filer
  def to_file_array(arr_file)
    arr_file.map do |filename|
      filename.split('/').last
    end
  end

  def get_photo_list(photo_dir)
    Dir[photo_dir.to_s + '/*']
  end
end
