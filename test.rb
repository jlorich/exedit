require 'exedit'
require 'pry'
Exedit.configure(lock: true) do |config|
  config.editors[:sublime] = 'subl -w -n'
  config.default_editor = :sublime
end

binding.pry

puts Exedit.open