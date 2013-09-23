require 'spec_helper'
require 'q/request_service'
require 'mocks/q/mock_db_service'

module Q
  describe RequestService do
    let(:db_service) {MockDBService.new}
    let(:request_service) {RequestService.new(db_service)}

    context "create request" do
      it "creates a new request" do
        user_id = 53111
        params = Hash[:title => "Blog title", :url => "some url", :description => "text**"]

        request = request_service.create(user_id, params)

        params[:user_id] = user_id
        db_service.attributes.should == params
      end
    end
  end
end
