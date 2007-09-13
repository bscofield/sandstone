module Sandstone
  module Models
    module Audit
      def self.included(base)
        base.class_eval do
          belongs_to :editor
          belongs_to :record, :polymorphic => true
          validates_presence_of :event, :editor_id
        end

        base.send(:extend, ClassMethods)
      end

      module ClassMethods
        def self.log(event, editor, record = nil, details = nil)
          attributes = {:event => event, :editor => editor}
          attributes[:details] = details if details
          attributes[:record] = record if record
          create(attributes)
        end
      end
    end
  end
end