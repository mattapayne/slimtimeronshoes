require 'rubygems'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", 'loader'))
require 'spec'
require 'spec/interop/test'

def mock_task(stub_args={})
  t = mock("Task")
  stub_args.each {|method, result| t.stub!(method, result)}
  t
end

def mock_app(stub_args={})
  a = mock("Shoes App")
  stub_args.each {|method, result| a.stub!(method, result)}
  a
end