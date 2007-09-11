# Uninstall hook code here
unless Kernel.const_defined?('RAILS_ROOT')
  Kernel.const_set('RAILS_ROOT', File.join(File.dirname(__FILE__), '..', '..', '..'))
end

if (File.exists?(RAILS_ROOT) && File.exists?(File.join(RAILS_ROOT, 'app')))
  require "#{RAILS_ROOT}/config/boot"
  require "#{RAILS_ROOT}/config/environment"
  require 'rails_generator'
  require 'rails_generator/scripts/destroy'

  Rails::Generator::Scripts::Destroy.new.run(['sandstone'])
end