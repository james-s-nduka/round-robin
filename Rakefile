env = ENV['ENVIRONMENT']

desc 'Run verification of new code'
task :verify do
  puts 'Verify TF and Cookbooks syntax and standards'
  sh 'terraform get'
  sh "terraform plan -var-file=#{env}.tfvars -state=#{env}.tfstate"
  puts 'Running Rubocop and Foodcritic tests'
  sh 'rubocop cookbooks'
  sh 'foodcritic cookbooks -f any'
end

desc 'Build environment'
task :build do
  puts "Provisioning and building #{env} environment using env config..."
  sh "terraform apply -var-file=#{env}.tfvars -state=#{env}.tfstate"
end

desc 'Run tests on the new environment'
task :test do
  puts 'Running Inspec Test Suites'
  web_server_ip = `terraform output -state="#{env}.tfstate" web_server_ip`
  app_server_1_ip = `terraform output -state="#{env}.tfstate" -module="app_servers" public_ip_0`
  app_server_2_ip = `terraform output -state="#{env}.tfstate" -module="app_servers" public_ip_1`
  ws = web_server_ip.chomp
  as_1 = app_server_1_ip.chomp
  as_2 = app_server_2_ip.chomp
  sh "inspec exec tests/web_server_spec.rb -t ssh://centos@#{ws} -i keys/mega_syndicate_west.pem"
  sh "inspec exec tests/app_server_spec.rb -t ssh://centos@#{as_1} -i keys/mega_syndicate_west.pem"
  sh "inspec exec tests/app_server_spec.rb -t ssh://centos@#{as_2} -i keys/mega_syndicate_west.pem"
end

desc 'De-provision environment'
task :destroy do
  puts 'De-provision environment'
  sh "terraform destroy -var-file=#{env}.tfvars -state=#{env}.tfstate -force"
end

desc 'Run Continuous Integration'
task ci_build: [:verify, :build, :test, :destroy] do
  puts 'Continuous Integration...'
end

desc 'Simple plan and build'
task provision: [:verify, :build] do
  puts "Delivery of the #{env} Environment..."
end
