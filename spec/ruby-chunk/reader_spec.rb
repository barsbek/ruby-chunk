require "spec_helper"

RSpec.describe RubyChunk::Reader do
  before(:each) do
    @test_file = "spec/testfile"
    @lines = File.readlines(@test_file).map(&:chomp)
    @content = File.read(@test_file)
    @reader = RubyChunk::Reader.new(@test_file)
  end

  def last_line_index
    @lines.count - 1
  end

  def joined_lines(from, to)
    @lines[from..to].join("\n")
  end

  def chomped_content
    @content.chomp
  end

  it "shows numbers of lines" do
    expect(@reader.lines_number).to eql(@lines.count)
  end

  it "should read whole file" do
    expect(@reader.read).to eql(@content)
  end

  it "should read particular bytes from file" do
    bytes = 100
    expect(@reader.read_bytes(bytes)).to eql(@content[0..bytes-1])
  end

  it "should read lines in range" do
    from = 4
    to = 6
    lines = joined_lines(from, to)
    expect(@reader.lines_in_range(from, to)).to eql(lines)
  end

  it "should read head of the file" do
    to = RubyChunk::Reader::LINES_NUMBER - 1
    head = joined_lines(0, to)
    expect(@reader.head).to eql(head)
  end

  it "should read tail of the file" do
    from = last_line_index - RubyChunk::Reader::LINES_NUMBER
    tail = joined_lines(from, last_line_index)
    expect(@reader.tail).to eql(tail)
  end

  it "should read particular number of lines from head" do
    number_of_lines = 3
    head = joined_lines(0, number_of_lines-1)
    expect(@reader.head(number_of_lines)).to eq(head)
  end

  it "should read particular number of lines from tail" do
    number_of_lines = 3
    from = last_line_index - number_of_lines
    tail = joined_lines(from, last_line_index)
    expect(@reader.tail(number_of_lines)).to eq(tail)
  end

  it "shouldn't fail on incorrect ranges" do
    big_number = @lines.count + 100
    expect(@reader.lines_in_range(0, 0)).to eql(@lines[0])
    expect(@reader.lines_in_range(-big_number, last_line_index)).to eql(chomped_content)
    expect(@reader.lines_in_range(-big_number, last_line_index)).to eql(chomped_content)
    expect(@reader.lines_in_range(0, big_number)).to eql(chomped_content)
    expect(@reader.lines_in_range(0, big_number)).to eql(chomped_content)
    expect(@reader.lines_in_range(-big_number, big_number)).to eql(chomped_content)
    expect(@reader.lines_in_range(big_number, big_number)).to be_nil
  end

  it "shouldn't fail on incorrect number of lines" do
    big_number = @lines.count + 100
    expect(@reader.tail(0)).to be_nil
    expect(@reader.tail(-big_number)).to be_nil
    expect(@reader.tail(big_number)).to eql(chomped_content)
    expect(@reader.head(0)).to be_nil
    expect(@reader.head(-big_number)).to be_nil
    expect(@reader.head(big_number)).to eql(chomped_content)
  end

  it "should read specific number of bytes from each line" do
    bytes = 10
    @reader.line_bytes = bytes
    lines = @lines.map{|line| line[0..bytes-1]}.join("\n")
    expect(@reader.read).to eql(lines)
  end

  it "number of bytes should be resettable" do
    @reader.line_bytes = 10
    @reader.reset_bytes
    expect(@reader.read).to eql(@content)
  end

  it "shouldn't fail on out-of-bounds bytes" do
    @reader.line_bytes = 10000
    expect(@reader.read).to eql(chomped_content)
    @reader.line_bytes = 0
    expect(@reader.read).to be_nil
    @reader.line_bytes = -10000
    expect(@reader.read).to be_nil
  end
end
