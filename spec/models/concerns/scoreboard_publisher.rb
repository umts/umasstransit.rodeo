# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples_for 'a scoreboard publisher' do
  let :factory_name do
    described_class.model_name.element.to_sym
  end

  it 'updates the scoreboard after create' do
    allow(ScoreboardService).to receive(:update)

    create(factory_name)
    expect(ScoreboardService).to have_received(:update)
      .with(with: instance_of(described_class))
  end

  it 'updates the scoreboard after update' do
    object = create(factory_name)
    allow(ScoreboardService).to receive(:update)

    object.save
    expect(ScoreboardService).to have_received(:update).with(with: object)
  end
end
