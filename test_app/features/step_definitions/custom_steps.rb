MIGRATION_FILES = ["create_authentications_table.rb","devise_create_users.rb"]

Then /^there is a user "([^"]*)"$/ do |email|
  User.where(:email=>email).all.size.should eq 1
end

Then /^there is a "([^"]*)" authentication associated with "([^"]*)"$/ do |provider, email|
  user_id = User.where(:email=>email).first.id
  Authentication.where(:user_id=>user_id, :provider=>provider).all.size.should eq 1
end

Given 'a working directory' do
  @working_dir = File.dirname(__FILE__)+"/../../"
end

Given /^I cleanup$/ do
  migrations_dir = "#{@working_dir}db/migrate/"
  begin
   Dir.entries(migrations_dir).each do |file|
     MIGRATION_FILES.each do |mfile|
       File.delete("#{migrations_dir}#{file}") if file.include? mfile
     end
   end
  rescue
  end
  
  FileUtils.rm_r("#{@working_dir}config/yettings/") rescue nil
  FileUtils.rm_r("#{@working_dir}app/views/devise/") rescue nil
  FileUtils.rm_r("#{@working_dir}app/views/users/") rescue nil  
  FileUtils.rm("#{@working_dir}app/models/user.rb") rescue nil
  FileUtils.rm("#{@working_dir}app/controllers/users_controller.rb") rescue nil
  FileUtils.rm("#{@working_dir}config/initializers/devise.rb") rescue nil
  FileUtils.rm("#{@working_dir}config/locales/devise.en.yml") rescue nil
  FileUtils.cp("#{@working_dir}features/resources/fresh_routes.txt","#{@working_dir}config/routes.rb") rescue nil
end

Then /^a timestamped file named '(.*)' is created in the '(.*)' directory$/ do |file,dir|
  full_dir = @working_dir+dir
  Dir.entries(full_dir).each do |timestamped_file|
    file = timestamped_file if timestamped_file.include? file
  end
  assert File.exists?(full_dir+file), "#{file} expected to exist, but did not"
  assert File.file?(full_dir+file), "#{file} expected to be a file, but is not"
end

When /^I run the install generator$/ do
  @generator_output = systemu("rails g devise_omniauth_engine:install true")
end

Then /^a file named "(.*)" is created in the "(.*)" directory$/ do |file,dir|
  full_dir = @working_dir+dir
  assert File.exists?(full_dir+file), "#{file} expected to exist, but did not"
  assert File.file?(full_dir+file), "#{file} expected to be a file, but is not"
end

Then /^the file "([^"]*)" contains "([^"]*)"$/ do |file, text|
  path = @working_dir+file
  file_content = IO.read(path)
  assert file_content.match(/#{text}/), "#{text} expected in #{path}"
end