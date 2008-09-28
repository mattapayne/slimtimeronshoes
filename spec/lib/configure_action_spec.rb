require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))

describe ConfigureAction do
  
  before(:each) do
    @action = ConfigureAction.new
    @app = mock_app(
      :alert => nil, :visit => nil, :stack => lambda { yield @app }, 
      :caption => nil, :para => nil,:button => lambda { yield @app })
    @action.app = @app
  end
  
  it "should ask the app to create a stack" do
    @app.should_receive(:stack)
    @action.execute
  end 
  
  it "should ask the app to create a caption" do
    @app.should_receive(:caption).with("Configure SlimTimer On Shoes")
    @action.execute
  end
end
