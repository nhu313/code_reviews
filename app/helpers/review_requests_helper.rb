module ReviewRequestsHelper

  def request_link_name(review_request)
    formate_date(review_request.posted_date) + " - " + review_request.title
  end

  private
  def formate_date(date)
    date.strftime("%m/%d")
  end
end
