module ApplicationHelper

  def title
    return content_for(:title) if content_for(:title)
    "Code Review Queue"
  end

  def user_first_name
    controller.user_first_name
  end

end
