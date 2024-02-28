Spring-Boot deployment using tomcat in a kubernetes cluster. 

Jenkins Environment:
1. Download Plugins: Docker Pipeline Plugin, SSH-agent and Docker Build plugin.
2. Setup Maven and JDK-17.
3. Create new pipeline, enable poll SCM for automatic build, test and, deployment whenever a commit made on this repo.
   Jenkins file path: ./app1/Jenkinsfile
   Branch: main
4. Add Credentials in Jenkins

SSH Username and Private Key of the K8s cluster 
Manage Jenkins>Manage Jenkins> Credentials > Add Credentials > Select Below Options:
Kind: SSH Username with private key
Scope: Global
ID:k8sCluste
Description: Kubernetes cluter server private key and username.
Username: USERNAME of the machine where kubernetes cluster hosted.
Private Key: Paste the contents of private key of the machine where kubernetes cluster hosted.
Passphrase: Include If any in the private key.

DockerHub Credentials
Manage Jenkins>Manage Jenkins> Credentials > Add Credentials > Select Below Options:
Kind: Username with password
Scope: Global
Username: USERNME of dockerhub account.
Password: PASSWORD of dockerhub account.
Description: DockerHub credentials.
ID: dockerhub

Add Kubernetes Server Username and IP as SECRET TEXT for SSH
Manage Jenkins>Manage Jenkins> Credentials > Add Credentials > Select Below Options:
Kind: Secret text
Scope: Global
Secret: UserName@Kubernetes-Server-IP (For Instance, myusername@10.10.10.10)
ID: USER-KubeServer
Description: UserName@KuAberntes-Server-IP as secret text

Kubernetes Cluster Configuration:
1. Turn off the strict host checking (Or, it won't let you login)
2. Deploy all the  yaml in the directory of nginx.

Access the app through nginx reverse proxy:
$ curl nodeip:30030/app1 (for instance, curl 192.168.49.1:30030/app1)