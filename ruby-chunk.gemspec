lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ruby-chunk/version"

Gem::Specification.new do |s|
  s.name = "ruby-chunk"
  s.version = RubyChunk::VERSION
  s.summary = "Gem for getting some part of the file"
  s.authors = ["barsbek"]
  s.email = "mak.bekmamat@gmail.com"
  s.files = ["lib/ruby-chunk.rb", "lib/ruby-chunk/version.rb", "lib/ruby-chunk/reader.rb"]
  s.homepage = "https://github.com/barsbek/ruby-chunk"
  s.license = 'MIT'

  s.add_development_dependency "rspec", "~> 3.6"
end
