require "spec_helper"

RSpec.describe RubyChunk::Reader do
  before(:each) do
    test_file = "spec/testfile"
    @test_content = File.read(test_file)
    @reader = RubyChunk::Reader.new(test_file)
  end

  it "shows numbers of lines" do
    lines_number = @test_content.split("\n").count
    expect(@reader.lines_number).to eql(lines_number)
  end

  it "reads whole file" do
    expect(@reader.read.size).to eql(@test_content.size)
  end

  it "reads particular bytes from file" do
    bytes = 100
    expect(@reader.read_bytes(bytes)).to eql(@test_content[0..bytes-1])
  end
end
