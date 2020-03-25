# frozen_string_literal: true

module ScoreboardHelper
  def sort_list(sort_order)
    # [[column_index, (0 = asc, 1 = desc)]]
    #
    # Name | Man1 | Man2 | ... | ManN  | OJ | Mans | CC | Quiz | Total
    # 0    |      |      |     | count | +1 | +2   | +3 | +4   | +5
    case sort_order
    when :total_score, nil
      [[Maneuver.count + 5, 1]]
    when :maneuver_score
      [[Maneuver.count + 2, 1]]
    when :participant_number
      [[0, 0]]
    end
  end

  def score_data(record)
    return { text: -9999, score: 0 } if record.blank?

    { text: record.score, score: record.score }
  end

  def score_cell(record, new:, edit: nil, allowed: false)
    if record.present?
      link_to_if (allowed && edit.present?), record.score, edit
    else
      link_to_if allowed, '&mdash;'.html_safe, new
    end
  end
end
