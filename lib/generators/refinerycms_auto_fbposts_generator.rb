class RefinerycmsAutoFbposts < Rails::Generators::Base

  source_root File.expand_path('../../../', __FILE__)

  def create_view_file
    copy_file 'app/views/admin/blog/posts/_form.html.erb'
  end

  def create_initializer_file
    puts "Updating active_record.observers in application.rb"
    application "config.active_record.observers = :facebook_post_observer"
  end

end
