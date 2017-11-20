require 'tempfile'

Given("a file {string} with content") do |path, content|
  @paths ||= []
  tmp_dir = File.expand_path("../../tmp", File.dirname(__FILE__))
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

Then("I want result to include file's path") do |table|
  step "I want result to include", table
end

Then("I want result to include first {int} lines") do |n|
  @current_paths.each do |path|
    lines = @files[path].scan /.*\n/
    lines = lines[0..n-1].join
    step "I want result to include", table([[ lines ]])
  end
end

Then("I want result to include last {int} lines") do |n|
  @current_paths.each do |path|
    lines = @files[path].split("\n")
    to = lines.size - 1
    from = to - n
    lines = lines[from..to].join("\n")
    step "I want result to include", table([[ lines ]])
  end
end
