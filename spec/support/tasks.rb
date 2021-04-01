# frozen_string_literal: true

require 'active_support'
require 'rake'

module TaskExampleGroup
  extend ActiveSupport::Concern

  included do
    # Make the Rake task available as `task` in your examples:
    subject(:task) { tasks[task_name] }

    let(:task_name) { self.class.top_level_description.sub(/\Arake /, '') }
    let(:tasks) { Rake::Task }
  end
end
