# TODO: refactor filesystem caching between page and page_template
# TODO: prevent overwriting application, public, and sandstone templates
module Sandstone
  module Models
    module PageTemplate
      LAYOUT_PATH = "#{RAILS_ROOT}/app/views/layouts"

      def self.included(base)
        base.class_eval do
          self.acts_as_versioned

          has_many :pages, :dependent => :nullify
          has_many :audits, :as => :record, :dependent => :destroy

          after_save :create_file_on_filesystem
          after_destroy :remove_file_from_filesystem

          validates_presence_of :name
          validates_uniqueness_of :name
        end

        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        private
        def layout_filename 
          "#{::PageTemplate::LAYOUT_PATH}/#{name.underscore}.html.erb"
        end

        def create_file_on_filesystem
          File.open(layout_filename, 'wb+') do |file|
            file.puts content
          end
        end

        def remove_file_from_filesystem
          File.delete layout_filename
        end
      end
    end
  end
end