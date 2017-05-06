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
