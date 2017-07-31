require 'yaml'

module Enoki
  class CLI < Thor
    no_commands do
      def settings
        @settings ||= YAML.load_file("./.enoki.yml")
      end
      
      def template_dir
        @template_dir ||= File.absolute_path(settings["template_dir"] || "templates")
      end
      
      def project_root_dir
        @project_root_dir ||= File.absolute_path(settings["project_root_dir"] || "./")
      end
      
      def project_file_path
        @project_file_path ||= begin
          if settings["project_file_path"].nil?
            raise "Error: Required settings not found in .enoki.yml! (project_file_path)"
          end
          File.absolute_path(settings["project_file_path"])
        end
      end
      
      def templates
        Dir.glob(File.join(template_dir, "*/")).map { |f| File.basename(f) }
      end
    end
  end
end
