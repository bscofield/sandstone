module Sandstone
  module Controllers
    module Audits
      # TODO: pagination
      def index
        @audits = Audit.find(:all, :order => 'id DESC', :limit => 50)
      end
    end
  end
end