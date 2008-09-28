class MainAction < Action
  
  def execute(obj=nil)
    app.background app.white
    app.stack :overflow => true, :margin => 8, :width => 0.95 do
      app.title "Tasks"
      app.flow do
        app.para app.link("New Task", :click => "/task/new") 
      end
      app.para "Below are all incomplete tasks."
      current_tasks = tasks(:show_completed => false)
      if current_tasks.empty?
        app.para "There are no incomplete tasks."
      else
        current_tasks.each do |task|
          completed = convert_date(task.completed_on)
          completed = "No" if completed.nil?
          app.flow do
            app.background app.silver, :angle => 20, :margin_bottom => 8, :curve => 15
            app.flow :margin => 12 do
              app.stack do
                app.para app.link(task.name).click { app.visit "/task/show/#{task.id}" }
              end
              app.stack do
                app.para "Created: #{convert_date(task.created_at)}"
                app.para "Completed: #{completed}"
                app.para "Hours: #{task.hours}"
              end
              if task_running?(task.id)
                app.button "Stop" do
                  app.visit "/task/stop/#{task.id}"
                end
              else
                app.button "Start" do
                  app.start_task(task)
                end
                app.button "Complete" do
                  app.complete_task(task)
                end
              end
            end
          end
        end
      end
    end
    if APP_ENV != "production"
      app.stack :width => 1.0 do
        app.caption "Debug info:"
        app.para Settings.settings.inspect
      end
    end
  end
  
end
