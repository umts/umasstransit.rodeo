# frozen_string_literal: true

class AppFormBuilder < ActionView::Helpers::FormBuilder
  def number_field_with_buttons(method, options = {})
    @template.number_field_tag_with_buttons(
      "#{@object_name}[#{method}]", object.send(method), options
    )
  end
end
