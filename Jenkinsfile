node('redhat01') {
	stage 'Checkout'
	// Get our code from the GitHub repository
	git url: 'https://github.com/james-s-nduka/round-robin.git'

	stage 'Verify'
	sh "export PATH=\\$PATH:/opt/chefdk/embedded/bin/"
    sh "export PATH=\\$PATH:/root/.chefdk/gem/ruby/2.1.0/bin"
    sh "export PATH=\\$PATH:/root/terraform/"
	// Verify syntax is fine
	sh  "rake ENVIRONMENT=build verify"

	// Provision the environment with code deployed
	stage 'Build'
	sh "export PATH=\\$PATH:/root/terraform/"
	sh "export PATH=\\$PATH:/root/.chefdk/gem/ruby/2.1.0/bin"
	sh "export PATH=\\$PATH:/opt/chefdk/embedded/bin/"
	sh "rake ENVIRONMENT=build build"

	// Run ServerSpec like tests on the environment
	stage 'Test'
	sh "export PATH=\\$PATH:/root/terraform/"
	sh "export PATH=\\$PATH:/root/.chefdk/gem/ruby/2.1.0/bin"
	sh "export PATH=\\$PATH:/opt/chefdk/embedded/bin/"
	sh "rake ENVIRONMENT=build test"

	// Check Deployment of environment
	stage 'Deploy'
	input 'Confirm the application is up and serving web service?'


	// Once we are done we destroy the short-lived environment
	stage 'Destroy'
	sh "export PATH=\\$PATH:/root/terraform/"
	sh "export PATH=\\$PATH:/root/.chefdk/gem/ruby/2.1.0/bin"
	sh "export PATH=\\$PATH:/opt/chefdk/embedded/bin/"
	input 'Confirm the destory of the newly provisioned environment?'
	sh "rake ENVIRONMENT=build destroy"
}
