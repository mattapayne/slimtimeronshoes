module TaskManager
  
  TASKS_FILE = "running_tasks.yml"
  
  private

  def tasks_running?
    return !running_tasks.empty?
  end
  
  def task_running?(task_id)
    if tasks_running?
      tasks = running_tasks.select {|t| t[:task_id] == task_id}
      return (tasks && !tasks.empty?)
    end
    return false
  end  

  def task_file_path
    File.join(File.dirname(__FILE__), "..", TaskManager::TASKS_FILE)
  end
  
  def task_file(mode="r", &block)
    unless File.exists?(task_file_path)
      File.new(task_file_path, File::CREAT)
    end
    File.open(task_file_path, mode) do |f|
      block.call(f) if block_given?
    end
  end
  
  def get_running_task(task_id)
    running_tasks.select {|t| t[:task_id] == task_id}.first
  end
  
  def stop_running_task(task_id)
    tasks = running_tasks.reject {|t| t[:task_id] == task_id}
    dump_tasks(tasks)
  end
  
  def running_tasks
    tasks = []
    task_file do |f|
      tasks = YAML.load(f) || []
      if tasks.is_a?(Hash)
        tasks = [tasks]
      end
    end
    return tasks
  end
  
  def start_running_task(task)
    tasks = running_tasks
    tasks << {:task_id => task.id, :started_at => Time.now}
    dump_tasks(tasks)
  end
  
  def dump_tasks(tasks)
    task_file(File::TRUNC|File::WRONLY) do |f|
      f.puts tasks.to_yaml
    end
  end
  
end
