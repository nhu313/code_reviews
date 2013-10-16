module Q
  class MockModel
    attr_accessor :id, :attributes, :filter, :data, :create_data

    def initialize(id = 1113)
      @id = id
      @create_data = self
    end

    def create!(attributes)
      @attributes = attributes
      create_data
    end

    def create_data=(data)
      @create_data = data
    end

    def data=(data)
      @data = data
    end

    def where(filter)
      @filter = filter
      data
    end

    def find(id)
      @id = id
      self
    end

    def find_by(filter)
      @filter = filter
      data.first if data
    end

    def all
      data
    end

    def update_attributes(attributes)
      @attributes = attributes
    end
  end
end
