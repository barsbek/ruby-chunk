module RubyChunk
  class Reader
    def initialize(file_path)
      @file = file_path
    end

    def lines_number
      File.foreach(@file).inject(0){|c| c+1}
    end

    def read
      File.read(@file)
    end

    def read_bytes(bytes)
      File.open(@file) do |f|
        f.read(bytes)
      end
    end

    def lines_in_range(from, to)
      result = []
      File.foreach(@file).with_index do |line, index|
        break if index > to
        result.push(line) if index >= from
      end
      result.join
    end

    def head(n = 10)
      lines_in_range(0, n - 1)
    end

    def tail(n = 10)
      last_index = lines_number - 1
      lines_in_range(last_index - n, last_index)
    end
  end
end
