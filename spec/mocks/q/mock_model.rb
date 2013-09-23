require 'mocks/q/mock_data'

module Q
  class MockModel
    attr_accessor :id, :attributes, :filter, :data, :create_data

    def initialize
      @create_data = MockData.new(1113)
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

    def all
      data
    end
  end
end
