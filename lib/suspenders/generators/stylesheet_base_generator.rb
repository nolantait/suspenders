require_relative "base"

module Suspenders
  class StylesheetBaseGenerator < Generators::Base
    def remove_prior_config
      remove_file "app/assets/stylesheets/application.css"
    end

    def add_css_config
      copy_file(
        "application.scss",
        "app/javascript/stylesheets/application.scss",
        force: true
      )
    end

    def add_css_to_js
      append_to_file(
        "app/javascript/packs/application.js",
        %(\nimport "../stylesheets/application.scss")
      )
    end

    def install_tailwindcss
      run "bin/yarn add tailwindcss@npm:@tailwindcss/postcss7-compat postcss@^7 autoprefixer@^9"
    end

    def remove_prior_postcss_config
      remove_file "postcss.config.js"
    end

    def add_postcss_config
      copy_file(
        "postcss.config.js",
        "./",
        force: true
      )
    end

    def add_tailwindcss_config
      run "npx tailwindcss init --full"
    end

    def install_fontawesome
      run "bin/yarn add @fortawesome/fontawesome-free@^5.14.0"
    end

    def add_ui_stylesheets_directory
      empty_directory "app/javascript/stylesheets/ui"
    end

    def add_ui_stylesheets
      base_path = "#{self.class.default_source_root}/ui"
      Dir.entries(base_path).each do |file|
        copy_file(
          [base_path, file].join('/'),
          "app/javascript/stylesheets/ui"
        )
      end
    end
  end
end
