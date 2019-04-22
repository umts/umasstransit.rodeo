# frozen_string_literal: true

module ScoringHelper
  def number_field_tag_with_buttons(name, value = nil, options = {})
    if range = options.delete(:in) || options.delete(:within)
      options.update(min: range.min, max: range.max)
    end
    value ||= options[:value]
    content_tag 'span', class: 'number-buttons' do
      concat number_field_tag name, value, options
      concat button_tag '-',
        class: 'btn btn-primary increment',
        type: :button,
        data: { field: sanitize_to_id(name), type: 'minus' },
        disabled: options[:min] && value == options[:min]
      concat button_tag '+',
        class: 'btn btn-primary increment',
        type: :button,
        data: { field: sanitize_to_id(name), type: 'plus' },
        disabled: options[:max] && value == options[:max]
    end
  end
end
