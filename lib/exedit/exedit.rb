require 'exedit/editor'
require 'exedit/command'
require 'dot_configure'

# A ruby external editor interface
module Exedit
  include Configurable

  class << self
    attr_accessor :editor

    def open(**kwargs)
      edit_command = options.editors[editor]

      Editor.new(edit_command, **kwargs).open
    end

    # All editors available on the current system
    def available_editors
      if !defined? @options
        base_editors.keys.select { |e| Command.which(e) }
      else
        options.editors.keys.select { |e| Command.which(e) }
      end
    end

    private

    def editor
      options.default_editor || available_editors.first
    end

    def base_editors
      {
        vi: 'vi',
        vim: 'vim',
        nano: 'nano',
        pico: 'pico'
      }
    end

    def default_options
      {
        editors: base_editors.select { |key, value| available_editors.include? key }
      }
    end
  end
end