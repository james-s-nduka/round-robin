env = ENV["ENVIRONMENT"] 

task :verify do
  puts "Verify TF syntax"
  sh "terraform get -var-file=#{env}.tfvars -state=${env}.tfstate -backup=-"
  sh "terraform plan -var-file=#{env}.tfvars -state=${env}.tfstate -backup=-"
end

task :build do
  puts "Provisioning and building #{env} environment using env config..."
  sh "terraform apply -var-file=#{env}.tfvars -state=${env}.tfstate -backup=-"
end

task :test do
  puts "Running Linting and Test Suites"
  sh "rubocop chef/cookbooks"
  sh "foodcritic chef/cookbooks -f any"
  sh "inspec"
end

task :destroy do
  puts "De-provision environment"
  "terraform destroy #{env} -var-file=#{env}.tfvars -force -state=${env}.tfstate -backup=-"
end

task :ci_build => [:verify, :build, :test, :destroy] do
  puts "Continuous Integration..."
end


task :production => [:verify, :build, :test] do
  puts "Delivery of the #{env} Environment..."
end