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
      conditional_link record.score, edit, (edit.present? && @can_edit_scores)
    else
      conditional_link '&mdash;'.html_safe, new, @can_edit_scores
    end
  end

  def conditional_link(text, url, conditional)
    if conditional
      link_to text, url
    else
      text
    end
  end
end
