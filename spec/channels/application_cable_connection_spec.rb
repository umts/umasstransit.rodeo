# frozen_string_literal: true

require 'rails_helper'

describe ApplicationCable::Connection do
  it 'allows anonymous connections' do
    expect { connect '/cable' }.not_to raise_error
  end
end
