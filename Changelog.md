# Changelog

## 2015/Nov/20-15:55 - bld1511201555
    - refactor unicon/shibboleth-idp base into this Dockerfile
    - move package downloads out of the Dockerfile
    - modified installs commands to use downloads
    - added our ncsuadlogin jar
    - reverted other-idp, it will get its own container
    - WAS: added other-idp install and logs volume

## 2015/Nov/19-15:04 - bld1511191504
    - fix Makefile to tag images better

## 2015/Nov/18-12:44 -
    - rebuild with IdP 3.2.0 

## 2015/Oct/22-12:41 - 
	- split this git and image out of the devel configs


