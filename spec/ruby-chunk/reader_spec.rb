require "spec_helper"

RSpec.describe RubyChunk::Reader do
  before(:each) do
    @test_file = "spec/testfile"
    @lines = File.readlines(@test_file)
    @content = @lines.join
    @reader = RubyChunk::Reader.new(@test_file)
  end

  def last_index
    @lines.count - 1
  end

  it "shows numbers of lines" do
    lines_number = @content.split("\n").count
    expect(@reader.lines_number).to eql(lines_number)
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
    lines = File.readlines(@test_file)[from..to].join
    expect(@reader.lines_in_range(from, to)).to eql(lines)
  end

  it "should read head of the file" do
    head = @lines[0..9].join
    expect(@reader.head).to eql(head)
  end

  it "should read tail of the file" do
    #TODO load from class the default number of lines
    tail = @lines[(last_index - 10)..last_index].join
    expect(@reader.tail).to eql(tail)
  end

  it "should read particular number of lines from head" do
    number_of_lines = 3
    head = @lines[0..number_of_lines-1].join
    expect(@reader.head(number_of_lines)).to eq(head)
  end

  it "should read particular number of lines from tail" do
    number_of_lines = 3
    from = last_index - number_of_lines
    tail = @lines[from..last_index].join
    expect(@reader.tail(number_of_lines)).to eq(tail)
  end
end
