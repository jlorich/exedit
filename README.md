# Exedit

Easily jump to external editors from a ruby script for input. (Like git does with commit messages)

## Installation

Add this line to your application's Gemfile:

    gem 'exedit'

And then execute:

    $ bundle

## Usage

To open a file in the default external editor, simply call

    result = Exedit.open ./path/to/file

The script will pause until the editor closes and the saved result will be read and returned.

If no file is specified, a tempfile will be generated and then destroyed immedately after the result is returned

    result = Exedit.open

#####String editing

You can also edit strings in external functions by using 

    result = Exedit.edit "my string!"

#####Editors

Commands to launch vim, nano, pico, sublime, and textmate are included by default. To open in a specific editor simply specify it when optining

    result = Exedit.open editor: :sublime

You can also manually pass in a command to launch an editor

     result = Exedit.open command: 'subl -n -w'

#####Options

Configurable options are availabe, including what editors can be launched and the default editor.

    Exedit.configure do |config|
      config.editors[:cooleditor] = 'cooleditor -w'
      config.default_editor = :cooleditor
    end

The following would set a hypothetical `cooleditor` as the default editor, launched with a command of `cooleditor -w ./path/to/file`


##### Editor Availability

`Exedit.available_editors` will return all editors availble on the current system.  The default configuration options also only include editors installed on the current system. If no `default_editor` is specified in the options, it will default to the first available editor on the system (typically vi)

## Contributing

1. Fork it ( https://github.com/jlorich/exedit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
