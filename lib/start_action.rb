class StartAction < Action
  
  def execute(obj=nil)
    if start(obj)
      app.alert("Started '#{obj.name}'.")
      app.visit '/'
    else
      app.alert("Could not start '#{obj.name}'.")
    end
  end
  
end
