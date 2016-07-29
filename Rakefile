env = ENV["ENVIRONMENT"] 

desc "Run verification of new code"
task :verify do
  puts "Verify TF and Cookbooks syntax and standards"
  sh "terraform get"
  sh "terraform plan -var-file=#{env}.tfvars -state=#{env}.tfstate"
  puts "Running Rubocop and Foodcritic tests"
  sh "rubocop chef/cookbooks"
  sh "foodcritic chef/cookbooks -f any"
end

desc "Build environment"
task :build do
  puts "Provisioning and building #{env} environment using env config..."
  sh "terraform apply -var-file=#{env}.tfvars -state=#{env}.tfstate"
end

desc "Run tests on the new environment"
task :test do
  puts "Running Linting and Test Suites"
  sh "inspec"
end

desc "De-provision environment"
task :destroy do
  puts "De-provision environment"
  sh "terraform destroy -var-file=#{env}.tfvars -state=#{env}.tfstate -force"
end

desc "Run Continuous Integration"
task :ci_build => [:verify, :build, :test, :destroy] do
  puts "Continuous Integration..."
end

desc "Simple plan and build"
task :provision => [:verify, :build] do
  puts "Delivery of the #{env} Environment..."
end
