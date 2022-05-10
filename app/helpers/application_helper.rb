module ApplicationHelper
  include Devise::Controllers::Helpers

  def full_title(page_title)
    base_title = "Open Rails"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def logged_in?
    current_user.present?
  end

  def current_user_admin?
    logged_in? && current_user.role == "admin"
  end
end
