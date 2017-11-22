require "spec_helper"

RSpec.describe RubyChunk::Reader do
  def content
    <<-EOF
Lorem Ipsum is simply dummy text of the printing
and typesetting industry. Lorem Ipsum has been the
industry's standard dummy text ever since the 1500s,
when an unknown printer took a galley of type and
scrambled it to make a type specimen book.
It has survived not only five centuries,
but also the leap into electronic typesetting, remaining
essentially unchanged. It was popularised in the 1960s
with the release of Letraset sheets containing
Lorem Ipsum passages, and more recently with
desktop publishing software like Aldus PageMaker
including versions of Lorem Ipsum.
    EOF
  end

  def lines_number
    content.split("\n").size
  end

  def lines(from, to)
    lines_array = content.scan /.*\n/
    lines_array[from..to].join
  end

  def last_line_index
    lines_number - 1
  end

  before(:each) do
    @reader = RubyChunk::Reader.new(content, StringIO)
  end

  it "shows numbers of lines" do
    expect(@reader.lines_number).to eql(lines_number)
  end

  it "should read whole file" do
    expect(@reader.read).to eql(content)
  end

  it "should read particular bytes from file" do
    bytes = 10
    expect(@reader.read_bytes(bytes)).to eql(content[0..bytes-1])
  end

  it "should read lines in range" do
    from, to = [1, 3]
    expect(@reader.lines_in_range(from, to)).to eql(lines(from, to))
  end

  it "should read head of the file" do
    head = lines(0, RubyChunk::Reader::LINES_NUMBER-1)
    expect(@reader.head).to eql(head)
  end

  it "should read tail of the file" do
    from = last_line_index - RubyChunk::Reader::LINES_NUMBER + 1
    tail = lines(from, last_line_index)
    expect(@reader.tail).to eql(tail)
  end

  it "should read particular number of lines from head" do
    number_of_lines = 3
    head = lines(0, number_of_lines-1)
    expect(@reader.head(number_of_lines)).to eq(head)
  end

  it "should read particular number of lines from tail" do
    number_of_lines = 3
    from = last_line_index - number_of_lines + 1
    tail = lines(from, last_line_index)
    expect(@reader.tail(number_of_lines)).to eq(tail)
  end

  it "shouldn't fail on incorrect ranges" do
    big_number = lines_number + 100
    expect(@reader.lines_in_range(0, 0)).to eql(lines(0, 0))
    expect(@reader.lines_in_range(-big_number, last_line_index)).to eql(content)
    expect(@reader.lines_in_range(0, big_number)).to eql(content)
    expect(@reader.lines_in_range(-big_number, big_number)).to eql(content)
    expect(@reader.lines_in_range(big_number, big_number)).to be_nil
  end

  it "shouldn't fail on incorrect number of lines" do
    big_number = lines_number + 100
    expect(@reader.tail(0)).to be_nil
    expect(@reader.tail(-big_number)).to be_nil
    expect(@reader.tail(big_number)).to eql(content)
    expect(@reader.head(0)).to be_nil
    expect(@reader.head(-big_number)).to be_nil
    expect(@reader.head(big_number)).to eql(content)
  end

  it "should read specific number of bytes from each line" do
    bytes = 10
    restr_lines = content.scan(/.*\n/).map{|line| line[0..bytes-1]}.join
    expect(@reader.read(10)).to eql(restr_lines)
  end

  it "shouldn't fail on out-of-bounds bytes" do
    expect(@reader.read(10000)).to eql(content)
    expect(@reader.read(0)).to be_nil
    expect(@reader.read(-10000)).to be_nil
  end
end
