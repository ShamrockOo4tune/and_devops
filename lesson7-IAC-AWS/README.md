TIL:
	- Infrastructure as a code (IAC) approcach concept. To set the infrastructure by describing it in the code, not by manual editing of configs of the servers. Can be declarative or script based imperative
        - IAC advantages: speed, price (both $ and time), reduced human generated  error risks
        - Two IAC methods. Push (Ansible) when desired configuration is send to the target host. Pull (Chef, Puppet) - target host requests its configuration  
        - Infrastructure provisioning tools overview (Terraform, AWS CloudFormation, Google Cloud, MS Azure)
        - Different levels of cloud services: 
		Infrastructure as a service - you recieve a server in the cloud and you configure it yourself, set the OS, install software, runn apps
                Platform as a service - you recieve a configured server with environment ready to go. You will only need you app to install, manage and run 
		Software as a service - you come to the resource and find it ready for your immediate needs, you do whatever calculation you need and leave. No need to set anything it comes all configured and redy
        - AWS ecosystem overview. Cloudformation 

Homework: to write AWS CF template for the given diagram (2 e.a. EC2 instances on different regions in virtual private cloud, load balancer. Use Identiy and access mangement
