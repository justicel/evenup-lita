#
# typecast.rb
#

module Puppet::Parser::Functions
  newfunction(:typecast, :type => :rvalue, :doc => <<-EOS
This outputs ruby argumentsects attempting to maintain their format to be read in from
a ruby configuration file
    EOS
  ) do |arguments|

    if arguments.length != 1
      return arguments
    end

    if arguments[0].is_a?(Hash) || arguments[0].is_a?(Array)
      # hashes and arrays will be inspected to display properly
      arguments[0].inspect
    elsif arguments[0].is_a?(Symbol)
      # symbols should remain symbols
      ":#{arguments[0]}"
    elsif arguments[0].is_a?(Fixnum) || arguments[0].is_a?(Float) || arguments[0].is_a?(TrueClass) || arguments[0].is_a?(FalseClass)
      arguments[0]
    else
      # must be a string so let's try to convert to a ruby type
      case arguments[0]
      when /^:/, /^[\{\[]/
        # found symbol, array, hash, bool, float, or fixnum
        arguments[0]
      when /^true$|^false$/
        # found boolean
        arguments[0] == 'true'
      when /^[0-9]+\.[0-9]+$/
        # found float
        arguments[0].to_f
      when /^[0-9]+/
        # found Fixnum
        arguments[0].to_i
      else
        # leave it as a string
        "\"#{arguments[0]}\""
      end
    end

  end
end
