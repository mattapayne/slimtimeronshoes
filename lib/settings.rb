class Settings
  
  API_KEY = "api_key"
  USERNAME = "username"
  PASSWORD = "password"
  COWORKERS = "coworkers"
  SETTINGS_FILE = "settings.yml"
  
  def self.api_key
    settings[Settings::API_KEY]
  end
  
  def self.username
    settings[Settings::USERNAME]
  end
  
  def self.password
    settings[Settings::PASSWORD]
  end
  
  def self.coworkers
    settings[Settings::COWORKERS]
  end
    
  def self.settings
    @@settings ||= load_settings
  end
  
  def self.configured?
    File.exists?(settings_file_path)
  end
  
  def self.save_settings(username, password, api_key, coworkers=nil)
    unless coworkers.nil?
      coworkers = coworkers.split(",").map {|cw| cw.strip }
    end
    begin
      File.open(settings_file_path, "w") do |f|
        f.puts({
            Settings::USERNAME => username, 
            Settings::PASSWORD => password, 
            Settings::API_KEY => api_key,
            Settings::COWORKERS => coworkers}.to_yaml)
        return "Successfully saved your settings."
      end
    rescue Exception => e
      return "An error occurred while saving your settings: #{e}."
    end
  end
  
  private
  
  def self.settings_file_path
    File.join(File.dirname(__FILE__), "..", Settings::SETTINGS_FILE)
  end
  
  def self.load_settings
    if configured?
      @@settings = YAML.load_file(settings_file_path)
    end
  end
  
end
