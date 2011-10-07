require "rake-pipeline"

class Rake::Pipeline
  module SpecHelpers

    # TODO: OS agnostic modules
    module FileUtils
      def mkdir_p(dir)
        system "mkdir", "-p", dir
      end

      def touch(file)
        system "touch", file
      end

      def rm_rf(dir)
        system "rm", "-rf", dir
      end

      def touch_p(file)
        dir = File.dirname(file)
        mkdir_p dir
        touch file
      end
    end
  end
end

RSpec.configure do |config|
  original = Dir.pwd

  config.include Rake::Pipeline::SpecHelpers::FileUtils

  def tmp
    File.expand_path("../tmp", __FILE__)
  end

  config.before do
    rm_rf(tmp)
    mkdir_p(tmp)
    Dir.chdir(tmp)
  end

  config.after do
    Dir.chdir(original)
  end
end