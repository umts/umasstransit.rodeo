# frozen_string_literal: true

module ScoringHelper
  # This is good advice generally, but in this case we want the method
  # signature to be the same as `check_box_tag`.
  # rubocop:disable Style/OptionalBooleanParameter
  def giant_check_box_tag(name, value = '1', checked = false, options = {})
    tag.div(class: 'd-inline-block btn-group-toggle checkbox',
            data: { toggle: 'buttons' }) do
      tag.label(class: ['btn', 'btn-primary', ('active' if checked)]) do
        concat check_box_tag name, value, checked, options
        concat tag.i
      end
    end
  end
  # rubocop:enable Style/OptionalBooleanParameter

  def number_field_tag_with_buttons(name, value = nil, options = {})
    if (range = options.delete(:in) || options.delete(:within))
      options.update(min: range.min, max: range.max)
    end
    value ||= options[:value]
    tag.div(class: 'input-group input-group-lg') do
      concat increment_button name, value, :-, options
      concat number_field_tag name, value, options
      concat increment_button name, value, :+, options
    end
  end

  def increment_button(target_field, value, type, options)
    types = {
      :+ => ['plus', :max, 'fa-plus'],
      :- => ['minus', :min, 'fa-minus']
    }
    disabled = (options[types[type][1]] && value == options[types[type][1]])

    button_tag(class: 'btn btn-primary increment input-group-append',
               type: :button,
               data: { field: sanitize_to_id(target_field),
                       type: types[type][0] },
               disabled: disabled) do
      tag.i class: ['fas', types[type][2]]
    end
  end
end
