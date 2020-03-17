module ApplicationHelper
  
  #ページ毎にタイトルを返す
  def full_title(page_name = "")
    base_title = "AttendanceB"
    if page_name.empty?
      base_titile
    else 
      page_name + " | " + base_title
    end
    
  end
end
