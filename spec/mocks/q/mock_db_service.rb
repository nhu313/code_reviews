require 'surrogate/rspec'
require 'q/db_service'

module Q
  class MockDBService
    Surrogate.endow(self)

    define(:initialize) {|model = "nothing"| @model = model}
    define(:create) {|attributes| model.new(attributes)}
    define(:find) {|filter| }
    define(:find_all) {|filter|}
  end

  describe DBService do
    it "checks mock DBService" do
      MockDBService.should be_substitutable_for(DBService)
    end
  end
end
