require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:default)

RSpec::Core::RakeTask.new(:all) do |t|
  t.rspec_opts = "--tag needs_rails"

  # t.rspec_opts = "--tag ~needs_rails"
end
