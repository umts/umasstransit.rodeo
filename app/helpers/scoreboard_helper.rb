# frozen_string_literal: true

module ScoreboardHelper
  def sort_order_button_class(button_order, current_order)
    if button_order == current_order then 'btn-primary'
    elsif button_order == :total_score && current_order.nil? then 'btn-primary'
    else 'btn-secondary'
    end
  end

  def score_cell(record, new:, edit: nil)
    if record.present?
      if edit.present? && @can_edit_scores
        link_to record.score, edit
      else
        record.score
      end
    else
      if @can_edit_scores
        link_to '&mdash;'.html_safe, new
      else
        '&mdash;'.html_safe
      end
    end
  end
end
