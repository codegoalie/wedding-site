module ApplicationHelper
  COLORS = %w(yellow magenta purple orange pink green)

  def pick_color
    COLORS.sample
  end
end
