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
      Editor.new(edit_command(editor, command), file).open
    end

    # Edits the given content in a tempfile
    def edit(content, editor: nil, command: nil)
      Editor.new(edit_command(editor, command), content: content).open
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

    def edit_command(editor, command)
      command || options.editors[editor || default_editor]
    end

    def default_editor
      options.default_editor || available_editors.keys.first
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
