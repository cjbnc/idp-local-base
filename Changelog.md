# Changelog

## 2017/Mar/02-11:33 - bld1703021133
    - reconfigured to work with Jetty 9.4.x upgrade
    - update Jetty to 9.4.2.v20170220

## 2017/Feb/08-16:48 - bld1702081648
    - removed the Attention block from the sidebar

## 2017/Feb/06-11:33 - bld1702061133
    - monthly rebuild for os updates
    - update Java to 8u121
    - update Jetty to 9.3.16.v20170120

## 2017/Jan/09-10:38 - bld1701091038
    - monthly rebuild for os updates
    - update Jetty to 9.3.15.v20161220 
    - Jetty 9.4.0 is now available, but not yet used

## 2016/Dec/12-09:43 - bld1612120943
    - update Jetty to 9.3.14.v20161028

## 2016/Nov/14-14:46 - bld1611141446
    - tweaks to style_301 and views to fix ucomm errors

## 2016/Nov/10-09:40 - bld1611100940
    - tweak to style_301.css to fix safari password box

## 2016/Nov/07-13:16 - bld1611071316
    - monthly rebuild for os updates
    - update Java to 8u112
    - update Jetty to 9.3.13.v20161014
    - change sysnews link on new look announcement

## 2016/Oct/28-12:51 - bld1610281251
    - incorporate ucomm 301 theme change

## 2016/Oct/10-08:29 - bld1610100829
    - monthly rebuild for os updates
    - update Jetty to 9.3.12.v20160915
    - removed custom TLS exceptions, Jetty requires TLS1.2

## 2016/Sep/12-09:46 - bld1609120946
    - monthly rebuild for os updates

## 2016/Aug/08-
    - monthly rebuild for os updates
    - update Java to 8u102
    - update Jetty to 9.3.11.v20160721

## 2016/Jul/11-11:35 - bld1607111135
    - monthly rebuild for os updates
    - update Jetty to 9.3.10.v20160621

## 2016/Jun/15-15:58 - bld1606151558
    - added requestlog configs to enable extended logging and timezone

## 2016/Jun/09-14:00 - bld1606091400
    - reconfigure SSL cipher rules to override new Jetty defaults
      Jetty 9.3.8+ disables ALL ciphers for TLS < 1.2
    - will no longer support IE8 / XP = TLSv1.0 DES-CBC3-SHA,
      but other TLS1 and TLS1.1 browsers work with the right ciphers

## 2016/Jun/06-10:06 - bld1606061006
    - monthly rebuild for os updates

## 2016/May/27-09:10 - bld1605270910
    - adds duo_shibboleth.zip to downloads
    - unpacks duo_shibboleth for use by other installs

## 2016/May/23-11:58 - bld1605231158
    - added port 80 to EXPOSE list
    - rebuild with latest centos7 distro
    - update Java to 8u92
    - update Jetty to 9.3.9.v20160517

## 2016/May/05-11:54 - bld1605051154
    - change sealer keep policy to 90 days

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


