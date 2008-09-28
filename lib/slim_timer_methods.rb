module SlimTimerMethods
  include TaskManager, Utility

  private
 
  def tasks(args={})
    args = {:show_completed => true, :roles => nil}.merge(args).reject {|k,v| v.nil?}
    wrapped do
      results = slimtimer_api.list_tasks(args[:show_completed], args[:roles])
      return results if args[:show_completed]
      return results.select {|rec| rec.completed_on.nil? }
    end
  end
  
  def create(name, tags, coworkers=nil, reporters=nil)
    wrapped do
      slimtimer_api.create_task(name, tags, coworkers, reporters, nil)
      return true
    end
    return false
  end
  
  def complete(task)
    wrapped do
      slimtimer_api.update_task(task.id, task.name, task.tags, nil, nil, Time.now)
      return true
    end
    return false
  end
  
  def start(task)
    wrapped do
      unless task_running?(task.id)
        start_running_task(task)
        return true
      end
    end
    return false
  end
  
  def stop(task, comments=nil, tags=nil)
    wrapped do
      if task_running?(task.id)
        running_task = get_running_task(task.id)
        end_time = Time.now
        start_time = running_task[:started_at]
        duration = (end_time - start_time).to_i
        slimtimer_api.create_timeentry(start_time, duration, task.id, end_time, tags, comments, false)
        stop_running_task(task.id)
        return true
      end
    end
    return false
  end
  
  def get_task(task_id)
    wrapped do
      return slimtimer_api.show_task(task_id)
    end
    return nil
  end

  def slimtimer_api
    @@api ||= SlimTimer.new(Settings.username, Settings.password, Settings.api_key)
  end
  
end
