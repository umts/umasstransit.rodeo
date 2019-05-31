# frozen_string_literal: true

module ScoreboardHelper
  def sort_list(sort_order)
    case sort_order
    when :total_score, nil
      [[Maneuver.count + 5, 1]]
    when :maneuver_score
      [[Maneuver.count + 2, 1]]
    when :participant_name
      #TODO
    when :participant_number
      [[0, 0]]
    end
  end

  def score_data(record)
    return { text: -9999, score: 0 } if record.blank?

    { text: record.score, score: record.score }
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
