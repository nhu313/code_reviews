class Models
  def self.map
    {:review_request => ReviewRequest,
      :review_reply => ReviewReply,
      :skipped_review_request => SkippedReviewRequest,
      :user => User}
  end
end
