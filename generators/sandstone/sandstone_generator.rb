module Rails
  module Generator
    module Commands
      
      class Create < Base
        def file_add_line_after(file, finder_line, added_line)
          gsub_file(file, Regexp.new('^(\s*' + finder_line + ')\s*$'),
            "\\1\n#{added_line}")
        end
      end
      
      class Destroy < RewindBase
        def file_add_line_after(file, finder_line, added_line)
          gsub_file(
            file, 
            Regexp.new('^(\s*)' + "#{added_line}" + '$'),
            '#\1\2'
          )
        end
      end
    end
  end
end

class SandstoneGenerator < Rails::Generator::Base

  def manifest
    template_dir = File.join(File.dirname(__FILE__), 'templates')
    
    record do |m|
      Dir.chdir(template_dir) do
        
        # handle models, controllers, helpers, and views
        %w(models controllers helpers views).each do |area|
          m.directory(File.join('app', area))
          Dir.glob(File.join(area, '**', '*')).each do |file|
            m.directory(File.join('app', file)) if File.directory?(file)
            m.file(file, File.join('app', file)) if File.file?(file)
          end
        end
                
        # handle tests
        m.directory('test')
        Dir.glob(File.join('test', '**', '*')).each do |file|
          m.directory(file) if File.directory?(file)
          m.file(file, file) if File.file?(file)
        end
      end
      
      # Create directory for cached CMS pages
      m.directory('app/views/pages/generated')

      # Handle CSS
      m.file('sandstone.css', 'public/stylesheets/sandstone.css')

      # Handle migrations
      Dir.glob(File.join(template_dir, 'migrate', '*')).each do |file|
        m.migration_template(
          File.join('migrate', File.basename(file)),
          'db/migrate',
          :migration_file_name => File.basename(file, '.rb')
        )
      end
    end
  end
    
end