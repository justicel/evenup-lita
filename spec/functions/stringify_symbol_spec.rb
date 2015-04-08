#! /usr/bin/env ruby -S rspec
require 'spec_helper'

describe "the typecast function" do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it "should exist" do
    expect(Puppet::Parser::Functions.function("stringify_symbol")).to eq("function_stringify_symbol")
  end

  it "should handle symbols" do
    result = scope.function_stringify_symbol([:test])
    expect(result).to(eq('test'))

    result = scope.function_stringify_symbol([':test'])
    expect(result).to(eq('test'))
  end
end
