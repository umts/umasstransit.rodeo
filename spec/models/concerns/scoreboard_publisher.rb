# frozen_string_literal: true

require 'rails_helper'

shared_examples_for 'a scoreboard publisher' do
  let :factory_name do
    described_class.model_name.element.to_sym
  end

  it 'updates the scoreboard after create' do
    allow(ScoreboardService).to receive(:update)
      .with(type: :add, with: instance_of(Participant))

    expect(ScoreboardService).to receive(:update)
      .with(with: instance_of(described_class))
    create factory_name
  end

  it 'updates the scoreboard after update' do
    object = create factory_name
    expect(ScoreboardService).to receive(:update)
      .with(with: object)
    object.save
  end
end
