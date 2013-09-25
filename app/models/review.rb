class Review

  def initialize(review_request, review_reply)
    @review_request = review_request
    @review_reply = review_reply
  end

  def title
    review_request.title
  end

  def taken?
    review_reply.reviewer_id
  end

  def submitted?
    review_reply.posted_date
  end

  private
  attr_reader :review_request, :review_reply
end
