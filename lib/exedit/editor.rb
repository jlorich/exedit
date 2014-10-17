require 'tempfile'

module Exedit
  # An exedit external editor instance
  class Editor
    attr_accessor :edit_command

    def initialize(edit_command, file_path = nil, content: nil)
      @file_path = file_path
      @edit_command = edit_command
      @content = content
    end

    def open
      (file.write(@content) && file.flush) if @content && !@file_path

      system("#{edit_command} #{file.path}")

      result = reload(file).read

      # Remove the tempfile if it exists
      tempfile.unlink if @tempfile

      result
    end

    private

    def file
      @file ||= @file_path ? File.new(@file_path) : tempfile
    end

    def tempfile
      @tempfile ||= Tempfile.new('ex-edit')
    end

    def reload(file)
      file.reopen(file.path)
    end
  end
end
