class Encoder
  EXTENSION = '.bmp'
  START_OFFSET = 64
  LAST_CHAR = 255.chr
  def self.encode(path,message)
    message += LAST_CHAR
    output_path = get_output_path(path)
    binary_message = to_binary_string(message)
    bitmap_file = File.binread path
    bitmap_file = bitmap_file.unpack('C*');
    output_file = encode_into_byte_array(bitmap_file,binary_message)
    write_to_file(output_file,output_path)
  end

  def self.write_to_file(output_file, output_path)
    File.open(output_path, 'wb') do |file|
      file.write output_file.pack('c*')
    end
  end


  def self.encode_into_byte_array(input_byte_array, binary_message)
    raise 'Not enough space in file' if (not_enough_space(binary_message,input_byte_array))
    output = input_byte_array
    for index in 0...(binary_message.length)
      print binary_message[index]
      output[index + START_OFFSET] = (input_byte_array[index] & ~1) | binary_message[index].to_i
    end
    output
  end

  def self.not_enough_space(binary_message, bitmap_file)
    space_needed = binary_message.length + START_OFFSET
    space_available = bitmap_file.length
    return space_available <= space_needed
  end


  def self.to_binary_string(message)
      char_array = message.split('')
      int_array = []
      bit_arrays = []
      for index in 0...(char_array.length)
        int_array.push(char_array[index].ord)
      end
      for index in 0...(int_array.length)
        bit_arrays.push(int_array[index].to_s(2).rjust(8,'0'))
      end
      bit_array = bit_arrays.join('')
  end

  def self.get_output_path(path)
    output = path
    output = output.reverse.sub(EXTENSION.reverse,'out'.reverse).reverse + EXTENSION
  end
end

class ResourceGatherer
  require 'rubygems'
  require 'rest-client'
  def self.download_image(path,url)
    File.open(path, 'wb' ) do |output|
      output.write RestClient.get(url)
    end
  end
end