require File.expand_path(File.dirname(__FILE__) + '/lib/sourcecode')
require File.expand_path(File.dirname(__FILE__) + '/lib/statistics')
require File.expand_path(File.dirname(__FILE__) + '/lib/rubymethods')

class Reflector
  def self.start
      puts "Welcome to Ruby Reflector!\nThis program will enlighten your parents and change your life.\n\n"
      quit = false
      rubymethods = RubyMethods.new("http://ruby-doc.org/core-1.9.3/").method_hash
      until(quit)
        puts "Do you want to analyze [f]ile, [d]irectory structure, [g]ithub repo, or [q]uit?"
        user_input = gets.downcase.chomp
        @stats = ''
        case user_input
        when "q"
          quit = true
        when "f"
          filename = ""
          until(filename.end_with?(".rb"))
            until(File.exists?(filename))
              if filename.length > 0
                puts "The filename entered must have an *.rb extension" unless filename.end_with?(".rb")
                puts "The file entered was not found, please try again." unless File.exists?(filename)
              end
              puts "Please enter the location of the ruby file (for example /User/myfile.rb)"
              filename = gets.chomp
              methods_list = SourceCode.from_file(filename).count_methods(rubymethods)
              @stats = Statistics.new(methods_list)
            end
          end  
          puts "How many of the top methods do you want to see? (Default is 10)"
          method_count = gets.chomp
          puts MethodReport.new(@stats.top_list(method_count.to_i)).format_and_display
        when "d"
          directoryname = "temp."
          while(directoryname.match(/\./))
            until(File.exists?(directoryname))
              if directoryname.length > 0
                puts "The directory entered was not found, please try again." unless directoryname == "temp."
              end
              puts "Please enter the location of the directory (for example /User/my_ruby_project)"
              directoryname = gets.chomp
              methods_list = SourceCode.from_dir(directoryname).count_methods(rubymethods)
              @stats = Statistics.new(methods_list)
            end
          end  
          puts "How many of the top methods do you want to see? (Default is 10)"
          method_count = gets.chomp 
          puts MethodReport.new(@stats.top_list(method_count.to_i)).format_and_display
        when "g"
          gitname = ""

          until(gitname.length > 0 && gitname.start_with?("git://github.com/")) #git://github.com/sharksforcheap/test.git
            puts "Git should start with 'git://github.com/', please try again." unless gitname.start_with?("git://github.com/") && gitname.length > 0
            puts "Please enter the git repository"
            gitname = gets.chomp
            methods_list = SourceCode.from_git(gitname).count_methods(rubymethods)
            @stats = Statistics.new(methods_list)
          end
          puts "How many of the top methods do you want to see? (Default is 10)"
          method_count = gets.chomp 
          puts MethodReport.new(@stats.top_list(method_count.to_i)).format_and_display
        end
      end
  end
end

Reflector.start