module Sandstone
  module Models
    module Caching
      def self.included(base)
        base.class_eval do
          after_save    :create_file_on_filesystem
          after_destroy :remove_file_from_filesystem
        end
        
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        def create_file_on_filesystem
          File.open(filename, 'wb+') do |file|
            file.puts content
          end
        end

        def remove_file_from_filesystem
          File.delete(filename) if File.exists?(filename)
        end
      end
    end
  end
end