stage 'Checkout'
// Get our code from the GitHub repository
git url: 'https://github.com/james-s-nduka/round-robin.git'

stage 'Verify'
// Verify syntax is fine
sh  "rake ENVIRONMENT=build verify"

// Provision the environment with code deployed
stage 'Build'
sh "rake ENVIRONMENT=build build"

// Run ServerSpec like tests on the environment
stage 'Test'
sh "rake ENVIRONMENT=build verify"

// Check Deployment into oenvironments
stage 'Deploy'
input 'Confirm the application ius up and serving web service?'


// Once we are done we destroy the short-lived environment
stage 'Destroy'
input 'Confirm the destory of the newly provisioned environment'
