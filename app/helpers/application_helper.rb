# frozen_string_literal: true

module ApplicationHelper
  def title_text(title)
    org = Rails.configuration.roadeo.organization
    event = Rails.configuration.roadeo.event_name
    [title, org, event].compact.join(' — ')
  end
end
