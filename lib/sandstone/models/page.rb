module Sandstone
  module Models
    module Page
      PAGE_PATH = "#{RAILS_ROOT}/app/views/pages/generated"
      EXPLICIT_ROUTES = ActionController::Routing::Routes.routes.inject([]) { |array, r| 
        array << r.segments.inject("") { |str,s| str << s.to_s }
      }

      def self.included(base)
        base.class_eval do
          after_save :retire_old_published_versions
          
          self.acts_as_versioned
          acts_as_tree

          has_many :audits, :as => :record, :dependent => :destroy
          has_many :page_variables, :dependent => :destroy
          belongs_to :page_template
          belongs_to :editor

          validates_presence_of   :status, :content
          validates_uniqueness_of :path
        end

        base.send(:include, Sandstone::Models::Caching)
        base.send(:include, InstanceMethods)
        base.send(:extend,  ClassMethods)
      end

      module InstanceMethods
        STATUSES = ['new', 'pending', 'published']

        def layout
          page_template ? "generated/#{page_template.name.underscore}" : 'public'
        end

        def draft=(value)
          self.status = 'new'
        end

        def approve=(value)
          self.status = 'pending'
        end

        def publish=(value)
          self.status = 'published'
        end
        
        def var(name, inherit = true)
          @variables ||= self.page_variables
          variable = @variables.detect { |variable| variable.name == name }

          if variable
            variable.content
          elsif inherit && self.parent
            self.parent.var(name, inherit) if self.parent
          end
        end
        
        def variable=(arr)
          arr.each do |id, record|
            unless record['name'].blank?
              self.page_variables.find(id).update_attributes(record)
            else
              self.page_variables.find(id).destroy
            end
          end
        end
        
        def new_variable=(arr)
          arr.each do |index, record|
            self.page_variables.create(record) unless record['name'].blank?
          end
        end
        
        def filename
          page_filename
        end
        
        def load_content_from_filesystem
          if File.exists?(page_filename)
            filesystem_content = File.read(page_filename).chomp
            update_attributes(:content => filesystem_content, :status => 'new') if filesystem_content != content
          end
        end
        
        def could_have_parent?
          unless self.parent_id
            page_count = ::Page.count
            page_count > 1 || self.new_record? && page_count == 1
          else
            true
          end
        end

        private
        def retire_old_published_versions
          self.versions.update_all('status = "retired"', ['version < ? AND status = ?', self.version, 'published']) if self.status == 'published'
        end

        def page_filename 
          "#{::Page::PAGE_PATH}/#{path? ? path : '_root'}.html.erb"
        end
      end

      module ClassMethods
        def find_roots(published_only = false)
          unless published_only
            find(:all, :conditions => {:parent_id => nil}, :include => :page_template)
          else
            ::Page::Version.find(:all, :conditions => {:parent_id => nil, :status => 'published'})
          end
        end

        def find_pending
          find_all_by_status('pending')
        end
      end
    end
  end
end