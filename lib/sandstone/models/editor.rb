module Sandstone
  module Modules
    module Editor
      ROLES = ['author', 'manager']

      belongs_to :user, :polymorphic => true
      has_many :pages, :dependent => :nullify
      has_many :events, :class_name => 'Audit', :dependent => :destroy
      has_many :audits, :as => :record, :dependent => :destroy

      validates_presence_of :user_id
      validates_uniqueness_of :user_id
      validates_inclusion_of :role, :in => ROLES

      def to_s
        "#{user.name} - #{role}"
      end

      def manager?
        role == 'manager'
      end

      def can_edit?(page)
        manager? || id == page.editor_id
      end
    end
  end
end