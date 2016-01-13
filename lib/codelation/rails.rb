module Codelation
  class Cli < Thor
    desc "rails:new", "Generate a codelation generic Rails template"
    long_desc <<-LONGDESC
      Generates a generic Rails template from the GitHub Repository
      - https://github.com/codelation/rails-project-template.git
    LONGDESC
    def rails_new(app_name)
      generate_rails_template(app_name)
    end
  end
end
