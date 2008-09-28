class ShowAction < Action
  
  def execute(obj=nil)
    task = get_task(obj)
    app.background app.white
    app.stack :margin => 12, :width => 0.98 do
      app.title "Task Details"
      app.para app.link("Go back", :click => '/')
      app.stack do
        app.background app.silver, :angle => 20, :margin_bottom => 8, :curve => 15
        app.flow do
          app.caption "ID:"
          app.para task.id
          app.caption "Name:"
          app.para task.name
        end
        app.flow do
          app.caption "Created at:"
          app.para convert_date(task.created_at)
          app.caption "Updated at:"
          app.para convert_date(task.updated_at)
        end
        app.flow do
          app.caption "Completed on:"
          app.para task.completed_on.nil? ? "Not complete" : convert_date(task.completed_on)
          app.caption "Hours:"
          app.para task.hours
        end
        app.flow do
          app.caption "Tags:"
          app.para task.tags
        end
        app.flow do
          app.caption "Role:"
          app.para task.role
        end
        app.flow do
          app.caption "Owners:"
          app.para task.owners.map {|o| o["name"]}.join(", ")
        end
        app.flow do
          app.caption "Co-workers:"
          unless task.coworkers.empty?
                app.para task.coworkers.join(", ")
          end
        end
        app.flow do
          app.caption "Reporters:"
          unless task.reporters.empty?
            app.para task.reporters.join(", ")
          end
        end
      end
    end
  end
end
