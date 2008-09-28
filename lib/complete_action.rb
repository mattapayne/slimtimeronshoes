class CompleteAction < Action
  
  def execute(obj=nil)
    continue = app.confirm("Are you sure you want to complete this task?")
    if continue
      if complete(obj)
        app.alert("Started #{obj.name}")
        app.visit '/'
      end
    else
      app.visit '/'
    end
  end
  
end
