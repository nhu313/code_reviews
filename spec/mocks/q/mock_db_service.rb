require 'surrogate/rspec'
require 'q/db_service'

module Q
  class MockDBService
    Surrogate.endow(self)
    attr_accessor :attributes

    define(:initialize) {|model = Hash|}
    define(:create) {|att| @attributes = att}
    define(:find) {|filter| }
    define(:find_all) {|filter|}
  end

  describe DBService do
    it "checks mock DBService" do
      MockDBService.should be_substitutable_for(DBService)
    end
  end
end
