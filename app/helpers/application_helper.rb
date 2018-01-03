module ApplicationHelper
  def full_title page_title = ""
    base_title = page_title.empty? ? "" : page_title + " | "
    base_title << (t "layouts.application.title")
  end
end
