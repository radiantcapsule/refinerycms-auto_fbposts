require 'refinerycms-base'

module Refinery
  module AutoFbposts

    class << self
      attr_accessor :root
      def root
        @root ||= Pathname.new(File.expand_path('../../', __FILE__))
      end
    end

    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.after_initialize do
        RefinerySetting.find_or_set(:auto_facebook_access_token, '')
        RefinerySetting.find_or_set(:auto_facebook_page, '000000000000000')
        RefinerySetting.find_or_set(:auto_facebook_message,
          'A new blog post "{title}" is published.')
      end

      require 'refinerycms/auto_fbposts'
      config.to_prepare do
        BlogPost.class_eval do
          include ::RefineryExtension::AutoFbposts
        end
      end
    end
  end
end
