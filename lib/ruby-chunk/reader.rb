module RubyChunk
  class Reader
    LINES_NUMBER = 10

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
        #TODO: last character of the lines should be new line character
        line = line[0..line_bytes-1] if line_bytes
        result.push(line) if index >= from
        index += 1
      end
      @file.rewind
      result.join
    end

    def head(n = nil, line_bytes = nil)
      n ||= Reader::LINES_NUMBER
      return nil if n < 1
      lines_in_range(0, n - 1, line_bytes)
    end

    def tail(n = nil, line_bytes = nil)
      n ||= Reader::LINES_NUMBER
      return nil if n < 1
      last_index = lines_number - 1
      lines_in_range(last_index - n + 1, last_index, line_bytes)
    end
  end
end
