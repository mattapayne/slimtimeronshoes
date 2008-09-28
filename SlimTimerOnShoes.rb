Shoes.setup do
  gem 'slimtimer4r'
end

require File.join(File.dirname(__FILE__), 'lib', 'loader')

class SlimTimerOnShoes < Shoes
 
  url '/', :index
  url '/task/new', :create_task
  url '/task/stop/(\\d+)', :stop_task
  url '/task/show/(\\d+)', :show_task
  
  @@actions = {
    :main => MainAction.new,
    :show => ShowAction.new,
    :configure => ConfigureAction.new,
    :complete => CompleteAction.new,
    :start => StartAction.new,
    :stop => StopAction.new,
    :create => CreateAction.new
  }
  
  def index
    Settings.configured? ? show_index : configure
  end
  
  def show_index
    run_action(:main)
  end
  
  def configure
    LoggerFacade.log("Application not configured. Bringing up configuration screen.", LoggerFacade::INFO)
    run_action(:configure)
  end
  
  def complete_task(task_id)
    run_action(:complete, task_id)
  end
  
  def start_task(task)
    run_action(:start, task)
  end
  
  def stop_task(task_id)
    run_action(:stop, task_id)
  end
  
  def create_task
    run_action(:create)
  end
  
  def show_task(task_id)
    run_action(:show, task_id)
  end
  
  private
  
  def run_action(action, *args)
    a = @@actions[action]
    a.app = self
    a.execute(*args)
  end
  
end

Shoes.app :title => "SlimTimer On Shoes", :width => 600, :height => 800, :resizable => true