class ConfigureAction < Action

  def execute(obj=nil)
    app.stack do
      app.caption "Configure SlimTimer On Shoes"
      app.para "Your user name:"
      @username = app.edit_line
      app.para "Your password:"
      @password = app.edit_line :secret => true
      app.para "Your api key:"
      @api_key = app.edit_line
      app.para "Default coworkers (these will be added to all new tasks):"
      @coworkers = app.edit_box
      app.button "Save" do
        errors = validate_configuration(@username.text, @password.text, @api_key.text)
        if errors.empty?
          app.alert(
            Settings.save_settings(
              @username.text, @password.text, 
              @api_key.text, @coworkers.text
            )
          )
          app.visit '/'
        else
          app.alert(errors.join("\n"))
        end
      end
    end
  end

end
