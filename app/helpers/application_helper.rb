# frozen_string_literal: true

module ApplicationHelper
  def nav_item(path, text = nil, role: nil)
    return if role.present? && !current_user.role?(role)

    tag.li class: 'nav-item' do
      link_to path do
        tag.button class: %w[mx-3 btn btn-outline-primary], type: 'button' do
          block_given? ? yield : text
        end
      end
    end
  end
end
