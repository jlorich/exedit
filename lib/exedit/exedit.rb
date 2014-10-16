require 'exedit/editor'
require 'exedit/command'
require 'dot_configure'

# A ruby external editor interface
module Exedit
  extend DotConfigure

  class << self
    attr_accessor :editor

    # Opens a file (defaults to a tempfile which will be deleted) for editing in the external editor
    def open(file = nil, editor: nil, command: nil)
      edit_command = command || options.editors[editor || default_editor]

      Editor.new(edit_command, file).open
    end

    # All editors available on the current system
    def available_editors
      if !defined? @options
        base_editors.select { |_editor, command| Command.which(command.split(' ')[0]) }
      else
        options.editors.select { |_editor, command| Command.which(command.split(' ')[0]) }
      end
    end

    private

    def default_editor
      options.default_editor || available_editors.first
    end

    def base_editors
      {
        vi: 'vi',
        vim: 'vim',
        nano: 'nano',
        pico: 'pico',
        sublime: 'subl -w -n',
        textmate: 'mate -w'
      }
    end

    def default_options
      {
        editors: base_editors.select { |key, _value| available_editors.include? key }
      }
    end
  end
end
