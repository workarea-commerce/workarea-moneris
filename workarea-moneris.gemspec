$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'workarea/moneris/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = 'workarea-moneris'
  s.version     = Workarea::Moneris::VERSION
  s.authors     = ['Jeff Yucis']
  s.email       = ['jyucis@weblinc.com']
  s.homepage    = 'https://github.com/workarea-commerce/workarea-moneris'
  s.summary     = 'Moneris payment processor.'
  s.description = 'Payment gateway for the Moneris payment processor.'
  s.files       = `git ls-files`.split("\n")

  s.add_dependency 'workarea', '~> 3.x'
end
