class LoggerFacade
  
  @@logger = Logger.new(APP_ENV == "development" ? STDOUT : 
      File.open('SlimTimerOnShoesErrors.log', File::WRONLY | File::APPEND | File::CREAT))
  @@logger.level = APP_ENV == "production" ? Logger::WARN : Logger::INFO

  FATAL = Logger::FATAL
  ERROR = Logger::ERROR
  WARN = Logger::WARN
  INFO = Logger::INFO
  DEBUG = Logger::DEBUG
  
  def self.log(message, status=LoggerFacade::INFO)
    case status
    when LoggerFacade::DEBUG
      @@logger.debug(message)
    when LoggerFacade::ERROR
      @@logger.error(message)
    when LoggerFacade::FATAL
      @@logger.fatal(message)
    when LoggerFacade::INFO
      @@logger.info(message)
    when LoggerFacade::WARN
      @@logger.warn(message)
    end
  end
  
end
