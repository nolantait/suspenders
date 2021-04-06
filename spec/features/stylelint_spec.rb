require "spec_helper"

RSpec.describe "suspenders:stylelint", type: :generator do
  context "generate" do
    it "creates .stylelintrc.json" do
      with_app { generate("suspenders:stylelint") }

      expect(".stylelintrc.json")
        .to match_contents(%r{"extends": "@thoughtbot/stylelint-config"})
    end

    it "adds stylelint and @thoughtbot/stylelint-config to the package.json" do
      with_app { generate("suspenders:stylelint") }

      expect("package.json").to match_contents(/devDependencies/)
      expect("package.json").to match_contents(/stylelint/)
      expect("package.json").to match_contents(%r{@thoughtbot/stylelint-config})
    end

  context "destroy" do
    it "removes .stylelintrc.json" do
      with_app do
        generate("suspenders:stylelint")
        destroy("suspenders:stylelint")
      end

      expect(".stylelintrc.json").not_to exist_as_a_file
    end

    it "removes stylelint and @thoughtbot/stylelint-config from package.json" do
      with_app do
        generate("suspenders:stylelint")
        destroy("suspenders:stylelint")
      end

      expect("package.json").not_to match_contents(/stylelint/)
      expect("package.json")
        .not_to match_contents(%r{@thoughtbot/stylelint-config})
    end
  end
end
