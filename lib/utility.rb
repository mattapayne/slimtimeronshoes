module Utility
  
  def convert_date(date, format="%m/%d/%Y at %I:%M%p")
    return if date.nil?
    date.strftime(format)
  end
  
  def wrapped
    begin
      return yield if block_given?
    rescue Exception => e
      LoggerFacade.log("An error occurred: #{e.inspect}", LoggerFacade::ERROR)
    end
  end
  
end
