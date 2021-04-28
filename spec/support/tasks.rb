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

    # This is for silencing, not expectations
    # rubocop:disable RSpec/ExpectOutput
    around do |example|
      original_stdout = $stdout
      $stdout = File.new(File::NULL, 'w')
      example.run
      $stdout = original_stdout
    end
    # rubocop:enable RSpec/ExpectOutput
  end
end
