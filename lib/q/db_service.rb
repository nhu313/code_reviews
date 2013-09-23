module Q
  class DBService

    def initialize(model)
      @model = model
    end

    def create(attributes)
      model.create!(attributes)
    end

    def find(filter)
      object = model.where(filter)
      object.first if object
    end

    def find_all(filter)
      model.where(filter)
    end

    def all
      model.all
    end

    private
    attr_reader :model
  end
end
