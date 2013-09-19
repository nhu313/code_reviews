module ApplicationHelper

  def title
    return content_for(:title) if content_for(:title)
    "Code Review Queue"
  end

  def user
    @user ||= controller.user
  end

end
