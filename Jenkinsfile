node('redhat01') {
	env.PATH = "/root/.chefdk/gem/ruby/2.1.0/bin:/root/terraform:/opt/chefdk/embedded/bin:${env.PATH}"
	env.AWS_ACCESS_KEY_ID = ''
	env.AWS_SECRET_ACCESS_KEY = ''
	env.AWS_DEFAULT_REGION = 'eu-west-1'
	
	stage 'Checkout'
	// Get our code from the GitHub repository
	git url: 'https://github.com/james-s-nduka/round-robin.git'

	stage 'Verify'
	// Verify syntax is fine
	sh  'rake ENVIRONMENT=build verify'

	// Provision the environment with code deployed
	stage 'Build'
	env.WORKSPACE = pwd()
	sh "aws s3 cp s3://syndicate-devops/ssh_keys/mega_syndicate_west.pem ${env.WORKSPACE}/keys/mega_syndicate_west.pem"
	sh 'rake ENVIRONMENT=build build'

	// Run ServerSpec like tests on the environment
	stage 'Test'
	sh 'rake ENVIRONMENT=build test'

	// Check Deployment of environment
	stage 'Deploy'
	input 'Confirm the application server is up and serving web service?'

	// Once we are done we destroy the short-lived environment
	stage 'Destroy'
	input 'Confirm the destory of the newly provisioned environment?'
	sh 'rake ENVIRONMENT=build destroy'
}
