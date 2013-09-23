module Q
  class DBService

    def initialize(model)
      @model = model
    end

    def create(attributes)
      model.create!(attributes)
    end

    def find(filter)
      model.where(filter).first
    end

    def find_all(filter)
      model.where(filter)
    end

    private
    attr_reader :model
  end
end
