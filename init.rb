# Include hook code here
%w(models helpers).each do |code_dir|
  directory = File.join(File.dirname(__FILE__), 'lib', code_dir) 
  
  Dependencies.load_paths << directory
  $LOAD_PATH << directory
  
  if code_dir == 'helpers'
    files_to_include = Dir.glob(File.join(directory, '*.rb'))
  
    files_to_include.each do |file|
      require file
    end
  end
end
