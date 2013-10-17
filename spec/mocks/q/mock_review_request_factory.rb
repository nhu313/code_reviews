class MockReviewRequestFactory

  def self.create(user_id)
    MockReviewRequest.new(user_id, 111)
  end

  def self.create_with_id(user_id, id)
    MockReviewRequest.new(user_id, id)
  end

  def self.create_completed_requests(user_id, size)
    create_taken_requests(user_id, size). each {|r| r.completed = true}
  end

  def self.create_taken_requests(user_id, size)
    create_open_requests(user_id, size). each {|r| r.taken = true}
  end

  def self.create_open_requests(user_id, size)
    (0...size).map do |id|
      MockReviewRequest.new(user_id, id)
    end
  end
end

private
class MockReviewRequest
  attr_accessor :user_id, :id, :review_reply, :completed, :taken, :posted_date

  def initialize(user_id, id = 1)
    @user_id = user_id
    @id = id
    @posted_date = DateTime.now
  end

  def completed?
    @completed
  end

  def taken?
    @taken
  end
end
