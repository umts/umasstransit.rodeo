# frozen_string_literal: true

namespace :versions do
  desc 'Reserialize version data as JSON'
  task reserialize: :environment do
    PaperTrail::Version.where.not(old_object: nil).where(object: nil).find_each do |version|
      from_yaml = PaperTrail::Serializers::YAML.load(version[:old_object])
      to_json = PaperTrail::Serializers::JSON.dump(from_yaml)
      version.update_column(:object, to_json)
    end
  end
end
