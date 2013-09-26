module Q
  class DBService

    def initialize(model)
      @model = model
    end

    def create(attributes)
      model.create!(attributes)
    end

    def save(record)
      record.save!
    end

    def find_first(filter)
      model.find_by(filter)
    end

    def find_by_id(id)
      model.find(id)
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
