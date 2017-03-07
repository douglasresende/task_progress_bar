# TaskProgressBar

[![Gem Version](https://badge.fury.io/rb/task_progress_bar.svg)](https://badge.fury.io/rb/task_progress_bar)
[![Build Status](https://api.travis-ci.org/douglasresende/task_progress_bar.svg?branch=master)](https://travis-ci.org/douglasresende/task_progress_bar)

A simple Ruby gem to show in terminal a progress bar as a task monitor, step by step.

## Getting started

```ruby
bar = TaskProgressBar.new( 100 )
1..10.times{ bar.step() }
# output
[10/100][#####                                             ][10%][00:00:01][00:00:15]
```

### Contributors

https://github.com/douglasresende/task_progress_bar/graphs/contributors

## License

MIT License. Copyright 2017 Douglas Resende. http://github.com/douglasresende/task_progress_bar

