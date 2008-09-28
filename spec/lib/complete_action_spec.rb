require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))

describe CompleteAction do
  
  before(:each) do
    @action = CompleteAction.new
    @app = mock_app(:alert => nil, :visit => nil)
    @action.app = @app
    @action.stub!(:complete)
  end
  
  it "should inherit from Action" do
    @action.class.superclass.should == Action
  end
  
  it "should attempt to get the specified task" do
    task = mock_task(:tags => "some tags", :id => "12345")
    @action.should_receive(:get_task).with("12345").and_return(task)
    @action.execute("12345")
  end
  
  it "should raise an exception if the task cannot be found" do
    @action.stub!(:get_task).and_return(nil)
    lambda {
      @action.execute("12345")
    }.should raise_error
  end
  
  it "should ensure the retrieved task is not nil before continuing" do
    task = mock_task(:tags => "some tags", :id => "12345")
    task.should_receive(:nil?).and_return(false)
    @action.stub!(:get_task).with("12345").and_return(task)
    @action.execute("12345")
  end
  
  it "should attempt to complete the task if the retrieved task is not nil" do
    task = mock_task(:name => "Task", :tags => "some tags", :id => "12345")
    @action.stub!(:get_task).with("12345").and_return(task)
    @action.should_receive(:complete).and_return(true)
    @action.execute("12345")
  end
  
  it "should alert the user that the task was successfully completed" do
    task = mock_task(:name => "Task", :tags => "some tags", :id => "12345")
    @action.stub!(:get_task).with("12345").and_return(task)
    @action.stub!(:complete).and_return(true)
    @app.should_receive(:alert)
    @action.execute("12345")
  end
  
  it "should take the user back to the main wiew if the task was successfully completed" do
    task = mock_task(:name => "Task", :tags => "some tags", :id => "12345")
    @action.stub!(:get_task).with("12345").and_return(task)
    @action.stub!(:complete).and_return(true)
    @app.should_receive(:visit).with("/")
    @action.execute("12345")
  end
  
end