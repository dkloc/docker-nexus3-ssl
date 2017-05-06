docker run -it --name nexus3 --rm -p 8443:8443 -e MYCERTNAME=mydevbox -e MYCERTPASSWORD=secret -v certs:/mycerts:ro test-nexus-ssl
