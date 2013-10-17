require 'mocks/q/mock_model'

module Q
  class MockModels

    def initialize
      @map = Hash.new
    end

    def [](model_name)
      @map[model_name] ||= MockModel.new
    end

    def add(model_name)
      @map[model_name] = MockModel.new
    end
  end
end
