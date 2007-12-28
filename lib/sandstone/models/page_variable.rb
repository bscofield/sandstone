module Sandstone
  module Models
    module PageVariable
      def self.included(base)
        base.class_eval do
          belongs_to :page

          validates_presence_of :name, :content
        end

        base.send(:include, InstanceMethods)
        base.send(:extend,  ClassMethods)
      end

      module InstanceMethods
      end

      module ClassMethods
      end
    end
  end
end