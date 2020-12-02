# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

RuboCop::RakeTask.new(:rubocop) do |t|
  t.options << '--config'
  t.options << File.expand_path('.rubocop.yml', __dir__)
end

RSpec::Core::RakeTask.new(:spec)

task default: %i[spec rubocop]
