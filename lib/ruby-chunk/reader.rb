module RubyChunk
  class Reader
    LINES_NUMBER = 10
    attr_accessor :line_bytes

    def initialize(file_path, io = File)
      @io = io
      @file_path = file_path
      @file = io.new(file_path)
    end

    def lines_number
      result = 0
      @file.each_line { result += 1}
      @file.rewind
      result
    end

    def read(line_bytes = nil)
      if line_bytes.nil?
        @file.read
      else
        lines_in_range(0, lines_number - 1, line_bytes)
      end
    end

    def read_bytes(bytes)
      @io.open(@file_path) do |f|
        f.read(bytes)
      end
    end

    def lines_in_range(from, to, line_bytes=nil)
      return nil if !line_bytes.nil? && line_bytes <= 0
      return nil if from > lines_number - 1
      result = []
      index = 0
      @file.each_line do |line|
        break if index > to
        line = line[0..line_bytes-1] if line_bytes
        result.push(line) if index >= from
        index += 1
      end
      @file.rewind
      result.join
    end

    def head(n = Reader::LINES_NUMBER, line_bytes = nil)
      return nil if n - 1 < 0
      lines_in_range(0, n - 1, line_bytes)
    end

    def tail(n = Reader::LINES_NUMBER, line_bytes = nil)
      return nil if n - 1 < 0
      last_index = lines_number - 1
      lines_in_range(last_index - n, last_index, line_bytes)
    end

    def reset_bytes
      remove_instance_variable(:@line_bytes)
    end
  end
end
