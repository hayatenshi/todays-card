module ApplicationHelper
  def time(time)
    time.strftime("%Y年 %-m月%-d日 %-H時%M分")
  end
end
