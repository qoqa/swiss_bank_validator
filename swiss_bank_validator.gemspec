require_relative 'lib/swiss_bank_validator/version'

Gem::Specification.new do |spec|
  spec.name          = "swiss_bank_validator"
  spec.version       = SwissBankValidator::VERSION
  spec.platform         = Gem::Platform::RUBY
  spec.authors       = ["QoQa dev Team"]
  spec.email         = ["dev@qoqa.com"]

  spec.summary       = %q{All you need to validate a Swiss Iban}
  spec.homepage      = "https://github.com/qoqa/swiss_bank_validator"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/qoqa/swiss_bank_validator"
  spec.metadata["changelog_uri"] = "https://github.com/qoqa/swiss_bank_validator/main/changelog.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel"
end
