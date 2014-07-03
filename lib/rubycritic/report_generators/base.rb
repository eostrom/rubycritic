require "erb"
require "rubycritic/report_generators/view_helpers"

module Rubycritic
  module Generator

    class Base
      def self.erb_template(template_path)
        ERB.new(File.read(File.join(TEMPLATES_DIR, template_path)))
      end

      TEMPLATES_DIR = File.expand_path("../templates", __FILE__)
      LAYOUT_TEMPLATE = erb_template(File.join("layouts", "application.html.erb"))

      include ViewHelpers

      def file_href
        "file://#{file_pathname}"
      end

      def file_pathname
        File.join(file_directory, file_name)
      end

      def file_directory
        root_directory
      end

      def file_name
        raise NotImplementedError.new("The #{self.class} class must implement the #{__method__} method.")
      end

      def render
        raise NotImplementedError.new("The #{self.class} class must implement the #{__method__} method.")
      end

      private

      def root_directory
        ::Rubycritic.configuration.root
      end

      def get_binding
        binding
      end
    end

  end
end
