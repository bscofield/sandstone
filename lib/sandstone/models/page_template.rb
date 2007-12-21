# TODO: refactor filesystem caching between page and page_template
# TODO: prevent overwriting application, public, and sandstone templates
module Sandstone
  module Models
    module PageTemplate
      LAYOUT_PATH = "#{RAILS_ROOT}/app/views/layouts/generated"

      def self.included(base)
        base.class_eval do
          self.acts_as_versioned

          has_many :pages,  :dependent => :nullify
          has_many :audits, :dependent => :destroy, :as => :record

          validates_presence_of   :name
          validates_uniqueness_of :name
        end

        base.send(:include, Sandstone::Models::Caching)
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        private
        def layout_filename 
          "#{::PageTemplate::LAYOUT_PATH}/#{name.underscore}.html.erb"
        end
      end
    end
  end
end