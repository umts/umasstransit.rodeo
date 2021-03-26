# frozen_string_literal: true

module ScoreboardHelper
  # Used to build the `data-sortlist` attribute for tableSorter's
  # initial sort. It's a two-element array with the first element being
  # the column index, and the second element being a 0 or 1 for "ascending"
  # or "descending". See https://mottie.github.io/tablesorter/docs/#sortlist
  #
  # [[column_index, (0 = asc, 1 = desc)]]
  #
  # ParticipantName | Man1 | Man2 | ... | ManN           | OJ | ManTotal | CC | Quiz | Total
  # 0               | 1    | 2    | ... | Maneuver.count | +1 | +2       | +3 | +4   | +5
  def sort_list(sort_order)
    case sort_order
    when :total_score, nil
      [[Maneuver.count + 5, 1]]
    when :maneuver_score
      [[Maneuver.count + 2, 1]]
    when :participant_number
      [[0, 0]]
    end
  end

  # Used to support JS math and sorting in tableSorter.
  # * `data-score` is the value for performing math -- the `math_textAttr`
  #   (a blank score is the same as a zero score for purposes of summing).
  #   See https://mottie.github.io/tablesorter/docs/example-widget-math.html#options
  # * `data-text` is the default value for sorting the table. A blank score is
  #   "lower" than all other scores (including possibly negative scores).
  #   `-9999` is much lower than anyone could possibly get on a maneuver;
  #   it's the same as the time penalty you would get if you took 2:53:39
  #   to complete the course.
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
