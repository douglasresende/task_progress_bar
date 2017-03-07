$:.push File.expand_path('../lib', __FILE__)
require 'task_progress_bar/version'

Gem::Specification.new do |s|
  s.name          = 'task_progress_bar'
  s.version       = TaskProgressBar::VERSION
  s.authors       = ['Douglas R Camargo']
  s.email         = ['douglas@maxstudio.com.br']
  s.homepage      = 'https://github.com/douglasresende/task_progress_bar'
  s.description   = %q{A simple Ruby gem to show in terminal a progress bar as a task monitor, step by step.}
  s.summary       = %q{A simple Ruby gem to show in terminal a progress bar as a task monitor, step by step.}
  s.date          = %q{2017-03-01}
  s.license       = 'MIT'

  s.require_paths = ['lib']
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
end
