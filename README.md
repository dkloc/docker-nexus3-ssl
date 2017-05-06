# Nexus 3 with docker registry
The aim of this project is to have nexus 3 configured with ssl. It has two advantages: the webinterface is secure and the docker registry is working.

## Default login/password
At first boot, the credentials are: admin/admin123

## Prerequisites
This image doesn't generate any self-signed certificates. You're expected to have valid certificates in p12 formats.

## Usage
Nexus uses a jetty keystore. This image is generating automatically a keystore based on a p12 you provide

Make sure you define these three parameters:
* -e MYCERTNAME=<filenameOfP12Withoutextension>
* -e MYCERTPASSWORD=<passwordToReadTheP12>
* -v <yourFolderWithP12file>:/mycerts:ro

## Configuration
Once started, this is what is recommended to do:
* Change admin password
* Go to administration and add some repos

## Getting docker registry
The following steps describe how to get a docker registry that is caching docker hub and enable you to push only to your private registry.

* Go to the administration page
* Go on repositories
* Create a docker hosted (this is your private registry)
** Use default parameters
** Set the name to "docker-hosted"
** Set Repository Connectors/HTTPS to 8445 (this is the port that will be used to push)
* Create a docker proxy (this is the cache of docker hub)
** Use default parameters
** Set the name to "docker-hub"
** Set the Proxy Remote Storage URL to "https://registry-1.docker.io"
** Set the Proxy Docker Index to "Use Docker Hub"
* Create a docker group
** Use default parameters
** Set the name to "docker"
** Set Repository Connectors/HTTPS to 8444 (this is the port that you will use to connect to the registry)
** In group, add "docker-hosted" and "docker-hub" as members

Your docker registry is ready. To use it:
> Make sure your docker client trusts the CA that signed your certificates. On *nix system, this page can be helpful: http://manuals.gfi.com/en/kerio/connect/content/server-configuration/ssl-certificates/adding-trusted-root-certificates-to-the-server-1605.html
> You need to trust the root ca and the intermediate ca. Do not forget to restart docker once new trusts are added (systemctl restart docker on Centos)
* `docker login <dns>:8444`
* Use credentials => you should have Login Succeeded

You can now pull and push. As an example, if you want to get alpine:
* docker pull <dns>:8444/alpine

You can push by:
* docker tag <image:tag> <dns>:8445/<image:tag>
* docker push <dns>:8445/<image:tag>
