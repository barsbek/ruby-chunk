# Ruby Chunk
**Ruby Chunk** is a gem for reading some part of the specified file or files.
It can help you `read` entire content, particular bytes from the beginning or each line. To read a range of line you can use one of `range`, `head` or `tail` commands, which are inspired by UNIX system's utilities [head](https://en.wikipedia.org/wiki/Head_(Unix)) and [tail](https://en.wikipedia.org/wiki/Tail_(Unix)). There is a special command `lines`, which can help you get info about number of lines from even very large files.


## Usage
After installing the gem
`gem install rubychunk`
you get an **executable**, which can receive **commands** and **options**, depending on various tasks.
```
Commands:
  rubychunk head [OPTIONS] FILES   # Print first 10 lines of FILES
  rubychunk help [COMMAND]         # Describe available commands or one specific command
  rubychunk lines FILES            # Print info about lines number of FILES
  rubychunk range [OPTIONS] FILES  # Print specified range of lines in every of FILES
  rubychunk read [OPTIONS] FILES   # Print content of FILES
  rubychunk tail [OPTIONS] FILES   # Print last 10 lines of FILES

Options:
  -c, [--line-bytes=N]
```
  
To get detailed info about **options** of particular command run:
`rubychunk help [COMMAND]`

## Ruby API
Before getting info from/about the file, you need to create *instance* of Reader class and then you can run instance methods depending on your purposes:
```
> require 'ruby-chunk'
> reader = RubyChunk::Reader('some/file/path')
> reader.lines_number
=> 3
```

####`reader.lines_number`
Get lines number of the file.

####`reader.read([line_bytes])`
Read **entire content** from file. 
Optional `lines_byte` argument helps to retrieve specific number of bytes from each line.

####`reader.read_bytes(bytes)`
Read particular **number of bytes** from the beginning of the file.

####`reader.lines_in_range(from, to, [line_bytes])`
Read **range of lines** `[from, to]`.
With `lines_byte` argument it reads specified number of bytes from each line.

####`reader.head([lines_number], [line_bytes])`
Read **first n lines** from the file.
If `lines_number` argument is not specified, then it retrieves first 10 lines.
With `lines_byte` argument it reads specified number of bytes from each line.

####`reader.tail([lines_number], [line_bytes])`
Read **last n lines** from the file.
If `lines_number` argument is not specified, then it retrieves last 10 lines.
With `lines_byte` argument it reads specified number of bytes from each line.

# Ruby Chunk
**Ruby Chunk** is a gem for reading some part of the specified file or files.
It can help you `read` entire content, particular bytes from the beginning or each line. To read a range of line you can use one of `range`, `head` or `tail` commands, which are inspired by UNIX system's utilities [head](https://en.wikipedia.org/wiki/Head_(Unix)) and [tail](https://en.wikipedia.org/wiki/Tail_(Unix)). There is a special command `lines`, which can help you get info about number of lines from even very large files.


## Usage
After installing the gem
`gem install rubychunk`
you get an **executable**, which can receive **commands** and **options**, depending on various tasks.
```
Commands:
  rubychunk head [OPTIONS] FILES   # Print first 10 lines of FILES
  rubychunk help [COMMAND]         # Describe available commands or one specific command
  rubychunk lines FILES            # Print info about lines number of FILES
  rubychunk range [OPTIONS] FILES  # Print specified range of lines in every of FILES
  rubychunk read [OPTIONS] FILES   # Print content of FILES
  rubychunk tail [OPTIONS] FILES   # Print last 10 lines of FILES

Options:
  -c, [--line-bytes=N]
```
  
To get detailed info about **options** of particular command run:
`rubychunk help [COMMAND]`

Example of code for getting info about lines number of multiple files.
```
> rubychunk lines first/file/path second/file/path
> first/file/path: 4
> second/file/path: 20
> Total: 24
```

## Ruby API
Before getting info from/about the file, you need to create *instance* of Reader class and then you can run instance methods depending on your purposes:
```
> require 'ruby-chunk'
> reader = RubyChunk::Reader('some/file/path')
> reader.lines_number
=> 3
```

####`reader.lines_number`
Get lines number of the file.

####`reader.read([line_bytes])`
Read **entire content** from file. 
Optional `lines_byte` argument helps to retrieve specific number of bytes from each line.

####`reader.read_bytes(bytes)`
Read particular **number of bytes** from the beginning of the file.

####`reader.lines_in_range(from, to, [line_bytes])`
Read **range of lines** `[from, to]`.
With `lines_byte` argument it reads specified number of bytes from each line.

####`reader.head([lines_number], [line_bytes])`
Read **first n lines** from the file.
If `lines_number` argument is not specified, then it retrieves first 10 lines.
With `lines_byte` argument it reads specified number of bytes from each line.

####`reader.tail([lines_number], [line_bytes])`
Read **last n lines** from the file.
If `lines_number` argument is not specified, then it retrieves last 10 lines.
With `lines_byte` argument it reads specified number of bytes from each line.

## License
MIT
