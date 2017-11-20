require 'tempfile'

Given("files with content") do |table|
  @paths = []
  tmp_dir = File.expand_path("../../tmp", File.dirname(__FILE__))
  table.rows_hash.each do |path, content|
    dir = File.expand_path(File.dirname(path), tmp_dir)
    FileUtils.mkdir_p(dir)
    file = Tempfile.new(path, tmp_dir)
    file.write(content)
    file.rewind
    @paths << file.path
  end
end

Given("a file path {string}") do |path|
  @current_paths = @paths.select{ |p| p.include? path }
  expect(@current_paths).not_to be_empty
end

Given("a list of file-paths") do |table|
  @current_paths = @paths.select do |p|
    table.raw.find{|row| p.include? row.first}
  end
end

When("I run command {string}") do |command|
  @obtained = `exe/rubychunk #{command} #{@current_paths.join(" ")}`
end

Then("I want result to include") do |table|
  table.raw.each do |row|
    content = row.first
    expect(@obtained).to include(content)
  end
end
