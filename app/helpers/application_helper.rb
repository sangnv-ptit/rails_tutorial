module ApplicationHelper
  def title title = ""
    title
  end

  def format_title title = ""
    base_title = title title
    title.empty? ? "" : base_title + " | "
  end

  def full_title page_title = ""
    format_title(page_title) + (t "layouts.application.title")
  end
end
