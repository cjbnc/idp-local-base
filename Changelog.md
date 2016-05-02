# Changelog

## 2016/May/02-10:23 - bld1605021023
    - minor changes to text on password reminder page
    - add correct sysnews link to sidebar

## 2016/Mar/17-12:21 - bld1603171221
    - adjust SSL settings for better https security

## 2016/Mar/09-15:52 - bld1603091552
    - adds touchfile to monitor config updates

## 2016/Mar/04-13:00 - bld1603041300
    - rewrite password expiring text for better flow

## 2016/Mar/02-14:53 - bld1603021453
    - configured view/messages for expiring password flow

## 2016/Mar/01-11:44 - bld1603011144
    - moved webapp/* to edit-webapp/ as recommended
    - fixing accesibility issues:
        - set lang="en-US" on all templates
        - tweak CSS to use darker red links on gray background
        - label bare-URL link in sidebar text
        - removed autofocus from forms
        - remove 3rd column of hidden data from IR page table
        - adds ARIA landmarks to pages
        - ensure content section exists to match all jump links

## 2016/Feb/22-14:52 - bld1602221452
    - sidebar and stale page messages changed
    - added script to copy/update sealer key
    - consolidated cron-scripts
    - add call to update_configs.sh at startup

## 2016/Feb/08-13:14 - bld1602081314
    - fixed https urls in footer
    - added a placeholder "click here" to sidebar
    - removed OIT logo from footers
    - reformed HTML+CSS for info release options
    - removed info release options, reformatted info page
    - update Java to 8u74
    - update Jetty to 9.3.7.v20160115

## 2016/Jan/19-13:57 - bld1601191357
    - added container-scripts/update-configs.sh
    - add cron pieces to run update-configs.sh periodically

## 2016/Jan/13-14:33 - bld1601131433
    - split sidebar content out of login and logout templates
    - changed logout default message, for pre-SLO

## 2016/Jan/12-15:06 - bld1601121506
    - add http://tuckey.org/urlrewrite/ lib for robust rewrite rules
    - removed jetty-rewrite configs

## 2016/Jan/07-10:13 - bld1601071013
    - clean up the SP info bits on the velocity templates

## 2015/Dec/21-10:58 - bld1512211058
    - rebuild with IdP 3.2.1
    - re-added "which" package removed from latest centos7 base

## 2015/Dec/03-16:43 - bld1512031643
    - enable rewrites in idp-rewrite configs
    - update Jetty to 9.3.6.v20151106
    - added ncsu-themed template files and images
    - removed remember my userid box from login
    - added message/handler for disabled accounts
    - update to jaas-ncsuadloginmodule-1.0.7-1.1
    - PasswordExpiring flow is not working due to IdP bug

## 2015/Nov/20-15:59 - bld1511201559
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


