require 'tempfile'

Given("a file {string} with content") do |path, content|
  @paths ||= []
  tmp_dir = File.expand_path("../../tmp/ruby-chunk", File.dirname(__FILE__))
  dir = File.expand_path(File.dirname(path), tmp_dir)
  FileUtils.mkdir_p(dir)
  file = Tempfile.new(path, tmp_dir)
  file.write(content)
  file.rewind
  @paths << file.path

  @files ||= {}
  @files[file.path] = content
end

Given("a file path {string}") do |path|
  @current_paths = @paths.select{ |p| p.include? path }
end

Given("a list of files") do |table|
  @current_paths = @paths.select do |p|
    table.raw.find{|row| p.include? row.first}
  end
end

When("I run command {string}") do |command|
  @result = `exe/rubychunk #{command} #{@current_paths.join(" ")}`
end

Then("result should contain {string}") do |content|
  expect(@result).to include(content)
end

Then("result shouldn't contain {string}") do |content|
  expect(@result).not_to include(content)
end
