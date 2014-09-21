class Decoder
  EXTENSION = '.bmp'
  START_OFFSET = 64
  LAST_CHAR = 255.chr
  def self.decode(path)
    bitmap_file = File.binread path
    bitmap_file = bitmap_file.unpack("C*")
    secret_message = get_secret_message(bitmap_file)
  end

  def self.get_secret_message(bitmap_file)
    output = ''
    bit_array = []
    bit_counter = 0
    for index in START_OFFSET...bitmap_file.length
      bit_counter += 1
      bit = (bitmap_file[index]%2).to_s
      bit_array.push(bit)
      if bit_counter%8 == 0
        bit_array = [bit_array.join('')].pack('B*')
        break if bit_array == LAST_CHAR
        output += bit_array
        bit_array = []
      end
    end
    puts output
  end
end