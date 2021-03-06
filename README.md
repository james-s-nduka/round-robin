# Round Robin 

A simple project demonstrating the round robin load balancing features of the NGINX web server using chef-zero to deploy the Web and App servers involved.

## Requirements
To run this project from your workstation you will need the following;
 
* Ruby 2.0 or above installed
* Terraform 6.8 or above installed
* AWS Secret Key and Access Key provided by maintainer (**DO NOT** check-in AWS creds into GitHub) 
* The "**mega_syndicate_west.pem**" placed in the keys directory
* Your workstation IP. You can use https://www.1and1.co.uk/ip-address to identify the address to use.

## Getting Started
1. Clone this GitHub Repository to your machine


2. Navigate to the base directory and place the ```mega_syndicate_west.pem```in the **keys** directory


3. Within the same directory edit the **local.tfvars** ```ip_for_ssh``` value with your workstation's IP address e.g. "93.232.83.232"  


4. Again, update the **local.tfvars** this time with the AWS secret and access keys provided


5. Run the Rake task to perform the provision, this will deploy the Web server and two App servers with the Sample Go code deployed.

Example;
```
	rake ENVIRONMENT=local provision
```
Finally, open a browser and enter the value of the ```web_server_address``` given in the output of the provision... Or use curl on the web_server_address to test it's round robin functionality :) 


## Integration tests

The inspec tests will ensure the functionaility of the web and app servers is expected and ensures all instances are secure. Run tests locally after performing the provision/build

```
	rake ENVIRONMENT=local test
```

Once done please decommission the environment by running 

```
	rake ENVIRONMENT=local destroy
```

## CI with Jenkins

You can keep up with the CI of this project here;

-  https://syndicate-devops.net/jenkins/job/Round_Robin_CI/

All steps are defined in the ```Jenkinsfile```

## TODO
* Establish an AMI build for patch updates to image (via Packer)
* Neglect chef-zero and use chef server

## Contributing

e.g.
1. Fork the repository on Github

2. Create a named feature branch (like `add_component_x`)

3. Write your change

4. Write tests for your change (if applicable)

5. Run the tests, ensuring they all pass

6. Submit a Pull Request using Github

## License and Authors

Authors: James Nduka 