require 'tempfile'

module Exedit
  class Editor
    attr_accessor :edit_command

    def initialize(edit_command, **kwargs, &block)
      @edit_command = edit_command
    end

    def open
      system("#{edit_command} #{tempfile.path}")

      result = reload(tempfile).read
      tempfile.unlink

      result
    end

    private

    def tempfile
      @tempfile ||= Tempfile.new('ex-edit')
    end

    def reload(file)
      file.reopen(file.path)
    end
  end
end