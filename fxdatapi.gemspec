# frozen_string_literal: true

require_relative "lib/fxdatapi/version"

Gem::Specification.new do |spec|
  spec.name = "fxdatapi"
  spec.version = Fxdatapi::VERSION
  spec.authors = ["Finbarrs Oketunji"]
  spec.email = ["f@finbarrs.eu"]
  spec.summary = "A Ruby Gem to interact with the Currency API"
  spec.description = "A Ruby Gem to interact with the Currency API."
  spec.homepage = "https://github.com/moatsystems/fxdatapi-rb"
  spec.required_ruby_version = ">= 2.6.0"
  spec.licenses = ['Nonstandard']
  spec.extra_rdoc_files = %w(LICENSE)
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/moatsystems/fxdatapi-rb"
  spec.metadata["changelog_uri"] = "https://github.com/moatsystems/fxdatapi-rb/CHANGLOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
