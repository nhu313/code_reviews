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
      @filter = {:id => id}
      @id = id
      return data.first if data
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

    def found_id
      @id
    end

    def found_data
      self
    end

    def search_filter
      @filter
    end
  end
end
