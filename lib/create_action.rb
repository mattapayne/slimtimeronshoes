class CreateAction < Action

  def execute(obj=nil)
    app.background app.white
    app.stack :margin => 12 do
      app.title "Create A New Task"
      app.para app.link("Go back", :click => "/"), :margin => 0 
    end
    app.stack :margin => 12 do
      app.background app.silver, :angle => 20, :curve => 15
      app.stack :margin => 8 do
        app.para "Task name:  ", :margin => 0
        @task_name = app.edit_line
        app.para "Co Workers:  ", :margin => 0
        @coworkers = app.edit_box
        @coworkers.text = Settings.coworkers.join(", ")
        app.para "Tags:  ", :margin => 0
        @tags = app.edit_line
        app.para "Reporters:  ", :margin => 0
        @reporters = app.edit_box
        app.button "Create task", :margin_top => 5 do
          errors = validate_new_task(@task_name.text)
          if errors.empty?
            if create(@task_name.text, @tags.text, @coworkers.text, @reporters.text)
              app.alert("Created '#{@task_name.text}'.")
              app.visit '/'
            else
              app.alert("An error occurred while creating the task.")
            end
          else
            app.alert(errors.join(", "))
          end
        end
      end
    end
  end
end
