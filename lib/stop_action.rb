class StopAction < Action
  
  def execute(obj=nil)
    task = get_task(obj)
    app.background app.white
    app.stack :margin => 12 do
      app.title "Stop Task"
      app.para app.link("Go back", :click => '/')
      app.stack do
        app.background app.silver, :angle => 20, :curve => 15
        app.stack :margin => 8 do
          app.para "Stop task: #{task.name}"
          app.para "Comments:", :margin => 0
          @comments = app.edit_box
          app.para "Tags:", :margin => 0
          @tags = app.edit_line
          app.button "Stop", :margin_top => 5 do
            if(stop(task, @comments.text, @tags.text))
              app.alert("Stopped '#{task.name}'.")
              app.visit '/'
            end
          end
        end
      end
    end
  end
  
end
