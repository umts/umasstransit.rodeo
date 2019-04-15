# frozen_string_literal: true

module ScoreboardHelper
  def sort_order_button_class(button_order, current_order)
    if button_order == current_order then 'btn-primary'
    elsif button_order == :total_score && current_order.nil? then 'btn-primary'
    else 'btn-secondary'
    end
  end
end
