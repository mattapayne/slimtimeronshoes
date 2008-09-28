module Validation
  
  USERNAME = "User name"
  PASSWORD = "Password"
  API_KEY = "API Key"
  TASK_NAME = "Task name"
  
  def validate(hash_of_values)
    errors = []
    hash_of_values.each do |key, value|
      if value.nil? || value.length == 0
        errors << "#{key} requires a value."
      end
    end
    errors
  end
  
  def validate_configuration(username, password, api_key)
    return validate(
      Validation::USERNAME => username,
      Validation::PASSWORD => password,
      Validation::API_KEY => api_key
    )
  end
  
  def validate_new_task(taskname)
    return validate(Validation::TASK_NAME => taskname)
  end
  
end
