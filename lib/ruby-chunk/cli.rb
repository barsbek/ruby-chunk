require "thor"
require "rainbow"

require "ruby-chunk/reader"

module RubyChunk
  class CLI < Thor
    #TODO: write detailed description of each option
    class_option "line-bytes", :aliases => "-c", type: :numeric 

    desc "read [OPTIONS] FILES", "Print content of FILES"
    method_option :bytes, :aliases => "-b", type: :numeric
    def read(*paths)
      output = []
      #TODO: too many similar code in methods => find ways to avoid it
      paths.each do |file|
        unless File.exists?(file)
          output << Rainbow("#{file} is not found").red
        else
          reader = Reader.new(file)
          output << Rainbow("#{file}:").green
          if options["line-bytes"]
            output << reader.read(options["line-bytes"])
          elsif options[:bytes]
            output << reader.read_bytes(options[:bytes])
          end
        end
      end
      print output.join("\n")
    end

    desc "range [OPTIONS] FILES",
    "Print specified range of lines in every of FILES"
    method_option :from, :aliases => "-f", default: 0
    method_option :to, :aliases => "-t"
    def range(*paths)
      output = []
      paths.each do |file|
        unless File.exists?(file)
          output << Rainbow("#{file} is not found").red
        else
          reader = Reader.new(file)
          output << Rainbow("#{file}:").green
          to = options[:to] || reader.lines_number - 1
          result = reader.lines_in_range(options[:from], to, options["line-bytes"])
          if result.nil?
            output << Rainbow("No lines in specified range").yellow
          else
            output << result
          end
        end
      end
      print output.join("\n")
    end


    desc "head [OPTIONS] FILES",
      "Print first #{Reader::LINES_NUMBER} lines of FILES"
    method_option :lines, :aliases => "-n", :type => :numeric
    def head(*paths)
      output = []
      paths.each do |file|
        unless File.exists?(file)
          output << Rainbow("#{file} is not found").red
        else
          reader = Reader.new(file)
          output << Rainbow("#{file}:").green
          if options["line-bytes"]
            output << reader.read(options["line-bytes"])
          elsif
            output << reader.head(options[:lines])
          end
        end
      end
      print output.join("\n")
    end

    desc "tail [OPTIONS] FILES",
    "Print last #{Reader::LINES_NUMBER} lines of FILES"
    method_option :lines, :aliases => "-n", :type => :numeric
    def tail(*paths)
      output = []
      paths.each do |file|
        unless File.exists?(file)
          output << Rainbow("#{file} is not found").red
        else
          reader = Reader.new(file)
          output << Rainbow("#{file}:").green
          if options["line-bytes"]
            output << reader.read(options["line-bytes"])
          elsif
            output << reader.head(options[:lines])
          end
        end
      end
      print output.join("\n")
    end

    desc "lines FILES",
      "Print info about lines number of FILES"
    def lines(*paths)
      total = 0
      output = []
      paths.each do |file|
        unless File.exists?(file)
          output << Rainbow("#{file} is not found").red
        else
          reader = Reader.new(file)
          lines = reader.lines_number
          total += lines

          output << "#{Rainbow(file).green}: #{lines}"
        end
      end
      output << "#{Rainbow('Total').blue}: #{total}"
      puts output.join("\n")
    end
  end
end
