#! /usr/bin/env ruby -S rspec
require 'spec_helper'

describe "the typecast function" do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it "should exist" do
    expect(Puppet::Parser::Functions.function("typecast")).to eq("function_typecast")
  end

  it "should handle hash" do
    result = scope.function_typecast([{'a' => 'b'}])
    expect(result).to(eq('{"a"=>"b"}'))

    result = scope.function_typecast(["{'a' => 'b'}"])
    expect(result).to(eq("{'a' => 'b'}"))
  end

  it "should handle array" do
    result = scope.function_typecast([['a', 'b']])
    expect(result).to(eq('["a", "b"]'))

    result = scope.function_typecast(["['a', 'b']"])
    expect(result).to(eq("['a', 'b']"))
  end

  it "should handle symbol" do
    result = scope.function_typecast([:bob])
    expect(result).to(eq(':bob'))

    result = scope.function_typecast([:bob])
    expect(result).to(eq(':bob'))
  end

  it "should handle Fixnums" do
    result = scope.function_typecast([10])
    expect(result).to(eq(10))

    result = scope.function_typecast(['10'])
    expect(result).to(eq(10))
  end

  it "should handle Float" do
    result = scope.function_typecast([10.3])
    expect(result).to(eq(10.3))

    result = scope.function_typecast(['10.3'])
    expect(result).to(eq(10.3))
  end

  it "should handle booleans" do
    result = scope.function_typecast([true])
    expect(result).to(eq(true))

    result = scope.function_typecast(['true'])
    expect(result).to(eq(true))

    result = scope.function_typecast([false])
    expect(result).to(eq(false))

    result = scope.function_typecast(['false'])
    expect(result).to(eq(false))
  end

  it "should return strings" do
    result = scope.function_typecast(['bob'])
    expect(result).to(eq('"bob"'))

    result = scope.function_typecast(['4bob'])
    expect(result).to(eq('"4bob"'))
  end

end
