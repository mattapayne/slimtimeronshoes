require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))

describe Action do
  
  it "should include SlimTimerMethods" do
    Action.included_modules.should include(SlimTimerMethods)
  end
  
  it "should include Utility" do
    Action.included_modules.should include(Utility)
  end
  
  it "should respond_to? execute" do
    Action.instance_methods.should include("execute")
  end
end
