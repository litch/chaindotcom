# http://www.ruby-doc.org/stdlib/libdoc/optparse/rdoc/classes/OptionParser.html
require 'optparse'

module Chaindotcom
  # @private
  class Parser
    def self.parse(args)
      new.parse(args)
    end

    def parse(args)
      return {} if args.empty?

      options = args.delete('--tty') ? {:tty => true} : {}
      begin
        parser(options).parse!(args)
      rescue OptionParser::InvalidOption => e
        abort "#{e.message}\n\nPlease use --help for a listing of valid options"
      end

      options
    end

    def parser(options)
      OptionParser.new do |parser|
        parser.banner = "Usage: chain [options] [files or directories]\n\n"

        parser.on('--init', 'Initialize your project with Chain.com.') do |cmd|
          ProjectInitializer.new.run
          exit
        end

        parser.on_tail('-h', '--help', "You're looking at it.") do
          # removing the blank invalid options from the output
          puts parser.to_s.gsub(/^\s+(#{invalid_options.join('|')})\s*$\n/,'')
          exit
        end

        # this prevents usage of the invalid_options
        invalid_options.each do |option|
          parser.on(option) do
            raise OptionParser::InvalidOption.new
          end
        end

      end
    end
  end
end