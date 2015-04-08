#
# stringify_symbol.rb
#

module Puppet::Parser::Functions
  newfunction(:stringify_symbol, :type => :rvalue, :doc => <<-EOS
This outputs ruby argumentsects attempting to maintain their format to be read in from
a ruby configuration file
    EOS
  ) do |arguments|

    if arguments.length != 1
      return arguments
    end

    if arguments[0].is_a?(Symbol)
      arguments[0].to_s
    elsif arguments[0][0] == ':'
      arguments[0][1..-1]
    else
      arguments[0]
    end

  end
end
