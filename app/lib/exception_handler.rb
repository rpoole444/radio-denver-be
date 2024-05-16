module ExceptionHandler
  class InvalidToken < StandardError
    def initialize(message = 'Invalid token')
      super
    end
  end
end
