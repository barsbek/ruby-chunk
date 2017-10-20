module RubyChunk
  class Reader
    LINES_NUMBER = 10

    def initialize(file_path)
      @file = file_path
      @line_bytes = nil
    end

    attr_accessor :line_bytes

    def lines_number
      File.foreach(@file).inject(0){|c| c+1}
    end

    def read
      if line_bytes.nil?
        #TODO something with end-of-lines in file's end
        File.read(@file)
      else
        lines_in_range(0, lines_number - 1)
      end
    end

    def read_bytes(bytes)
      File.open(@file) do |f|
        f.read(bytes)
      end
    end

    def lines_in_range(from, to)
      return nil if !line_bytes.nil? && line_bytes <= 0
      return nil if from > lines_number - 1
      result = []
      File.foreach(@file).with_index do |line, index|
        break if index > to
        line = line.chomp
        line = line[0..line_bytes-1] if line_bytes
        result.push(line) if index >= from
      end
      result.join("\n")
    end

    def head(n = Reader::LINES_NUMBER)
      return nil if n - 1 < 0
      lines_in_range(0, n - 1)
    end

    def tail(n = Reader::LINES_NUMBER)
      return nil if n - 1 < 0
      last_index = lines_number - 1
      lines_in_range(last_index - n, last_index)
    end

    def reset_bytes
      remove_instance_variable(:@line_bytes)
    end
  end
end
