# frozen_string_literal: true

require_relative 'lib/faraday/pkcs7/version'

Gem::Specification.new do |spec|
  spec.name = 'faraday-pkcs7'
  spec.version = Faraday::PKCS7::VERSION
  spec.authors = ['Alexander Popov']
  spec.email = ['alex.wayfer@gmail.com']

  spec.summary = 'Faraday middleware for encryption and decryption PKCS7 containers'
  spec.description = <<~DESC
    Faraday middleware for encryption and decryption PKCS7 containers.
  DESC
  spec.license = 'MIT'

  github_uri = "https://github.com/AlexWayfer/#{spec.name}"

  spec.homepage = github_uri

  spec.metadata = {
    'bug_tracker_uri' => "#{github_uri}/issues",
    'changelog_uri' => "#{github_uri}/blob/v#{spec.version}/CHANGELOG.md",
    'documentation_uri' => "http://www.rubydoc.info/gems/#{spec.name}/#{spec.version}",
    'homepage_uri' => spec.homepage,
    'rubygems_mfa_required' => 'true',
    'source_code_uri' => github_uri,
    'wiki_uri' => "#{github_uri}/wiki"
  }

  spec.files = Dir['lib/**/*', 'README.md', 'LICENSE.md', 'CHANGELOG.md']

  spec.required_ruby_version = '>= 2.5', '< 4'

  spec.add_runtime_dependency 'faraday', '~> 2.4'
  spec.add_runtime_dependency 'pkcs7-cryptographer', '~> 1.1'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.21.0'

  spec.add_development_dependency 'rubocop', '~> 1.30.0'
  spec.add_development_dependency 'rubocop-packaging', '~> 0.5'
  spec.add_development_dependency 'rubocop-performance', '~> 1.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.0'
end
