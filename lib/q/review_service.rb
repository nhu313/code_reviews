require 'q/db_service'

module Q
  class ReviewService

    def initialize(model)
      @db_service = Q::DBService.new(model)
    end


    private
    attr_reader :db_service
    
  end
end
