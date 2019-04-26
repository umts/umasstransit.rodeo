# frozen_string_literal: true

module ScoringHelper
  def giant_check_box_tag(name, value = '1', checked = false, options = {})
    classes = options.delete(:class).to_s.split(' ')
    classes << 'checkbox-big'
    classes = classes.join(' ')
    concat check_box_tag name, value, checked, options.merge(class: classes)
    content_tag 'div', '', class: 'pseudo-checkbox'
  end

  def number_field_tag_with_buttons(name, value = nil, options = {})
    if (range = options.delete(:in) || options.delete(:within))
      options.update(min: range.min, max: range.max)
    end
    value ||= options[:value]
    content_tag 'div', class: 'input-group input-group-lg' do
      concat number_field_tag name, value, options
      concat increment_button name, value, :-, options
      concat increment_button name, value, :+, options
    end
  end

  def increment_button(target_field, value, type, options)
    types = { :+ => ['plus', :max], :- => ['minus', :min] }
    disabled = (options[types[type][1]] && value == options[types[type][1]])

    button_tag type,
               class: 'btn btn-primary increment input-group-append',
               type: :button,
               data: { field: sanitize_to_id(target_field),
                       type: types[type][0] },
               disabled: disabled
  end
end
