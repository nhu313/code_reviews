require 'spec_helper'
require 'q/services/review_request'
require 'q/services/factory'

module Q
  module Services
    describe ReviewRequest do
      let(:user_id) {777}
      let!(:model){Factory.models[:review_request]}
      let(:service){Factory.create(:review_request, user_id)}
      let(:params) {Hash[:title => "Blog title", :url => "some url", :description => "text**",
        :extra_param => "something"]}

        context "create request" do
          it "creates a new request" do
            DateTime.stub(:now).and_return("04/10/2033")

            request = service.create(params.clone)
            model.attributes.should == expected_attributes(params)
          end

          def expected_attributes(attributes)
            attributes.delete(:extra_param)
            attributes[:user_id] = user_id
            attributes[:posted_date] = DateTime.now
            attributes
          end
        end

        it "finds the request given a request id" do
          request_id = 88422;
          service.find(request_id)
          model.id.should == request_id
        end

        context "validate" do
          it "is invalid when attribute is nil" do
            service.should_not be_valid(nil)
          end

          it "is invalid when there is no title" do
            params.delete(:title)
            service.should_not be_valid(params)
          end

          it "is invalid when there is no url" do
            params.delete(:url)
            service.should_not be_valid(params)
          end

          it "is invalid when there is a description but no title or url" do
            params = Hash[:description => "text**"]
            service.should_not be_valid(params)
          end

          it "is valid when there are title and url, and no description" do
            params.delete(:description)
            service.should be_valid(params)
          end

          it "is valid when there are title, url, and description" do
            service.should be_valid(params)
          end

        end

        it "archives request" do
          review_request_id = 11
          service.archive(review_request_id)
          model.id.should == review_request_id
          model.attributes.should == {:archive => true}
        end
      end
    end
  end
