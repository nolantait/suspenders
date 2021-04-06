require_relative "base"

module Suspenders
  class LintGenerator < Generators::Base
    def set_up_rubocop
      copy_file "rubocop.yml", ".rubocop.yml"
    end
  end
end
