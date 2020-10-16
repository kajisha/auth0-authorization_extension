require_relative 'lib/auth0/authorization_extension/version'

Gem::Specification.new do |spec|
  spec.name          = 'auth0-authorization_extension'
  spec.version       = Auth0::AuthorizationExtension::VERSION
  spec.authors       = ["Hiroshi Kajisha"]
  spec.email         = ["kajisha@gmail.com"]

  spec.summary       = 'Auth0 Authorization Extension'
  spec.description   = 'Ruby toolkit for Auth0 Authorization Extension API https://auth0.com/docs/api/authorization-extension'
  spec.homepage      = 'https://github.com'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'auth0'
  spec.add_runtime_dependency 'rest-client'
  spec.add_runtime_dependency 'jwt'
  spec.add_runtime_dependency 'zache'
end
