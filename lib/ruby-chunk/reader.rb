module RubyChunk
  class Reader
    def initialize(file_path)
      @file = file_path
    end

    def lines_number
      %x(wc -l "#{@file}").to_i
    end

    def read
      File.read(@file)
    end

    def read_bytes(bytes)
      File.open(@file) do |f|
        f.read(bytes)
      end
    end
  end
end
