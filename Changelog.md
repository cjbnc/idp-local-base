# Changelog

## 2022/Jun/06 - bld2206061129
    - update to NCSU AD Login 1.2 (and 1.2n)

## 2022/May/03 - bld2205030919
    - final build for Duo OIDC release

## 2022/Apr/20 - bld2204200942
    - idp 4.2.1
    - java 11.0.15.9

## 2022/Apr/15 - bld2204151339
    - rename to idp42-local-base
    - idp 4.2.0
    - oidc-common plugin 2.0.0
    - duo-oidc plugin 1.2.0

## 2022/Apr/11 - bld2204111222
    - idp 4.1.6
    - jetty 9.4.46

## 2022/Mar/24 - bld2203241252
    - update versions on oidc/duo plugins
    - improve handling to add plugins

## 2022/Feb/07 - bld2202071252
    - jetty 9.4.45
    - java 11.0.14.9
    - idp 4.1.5

## 2022/Jan/10 - bld2201101053
    - loads NCSU AD module 1.2 with password expiration turned off

## 2021/Dec/15 - bld2112151454
    - disable auto-loading logback.xml changes to protect against JNDI exploit

## 2021/Nov/16 - bld2111161042
    - moved main repo to github

## 2021/Oct/11 - bld2110110939
    - update jetty to 9.4.44

## 2021/Aug/09 - bld2108091116
    - update IdP to 4.1.4
    - update Java to 11.0.12.7

## 2021/Jul/13 - bld2107130807
    - update jetty to 9.4.43

## 2021/Jun/07 - bld2106071327
    - update idp to 4.1.2
    - re-add okio jar no longer provided by the idp
    - update jetty to 9.4.41

## 2021/Apr/12 - bld2104121208
    - update base to idp 4.1.0
    - update jetty to 9.4.39

## 2021/Mar/08 - bld2103081232
    - update jetty to 9.4.38

## 2021/Feb/08 - bld2102081123
    - update java to 11.0.10.9 and switch to yum repo source
    - update jetty to 9.4.36
    - switch unity logo file from cdn to generic name
    - switch to multi-stage build, image smaller by 30%

## 2020/Nov/09 - bld2011090938
    - update Java to 11.0.9
    - updated Jetty to 9.4.34 with XFF fixes

## 2020/Oct/15 - bld2010151042
    - re-added new etc/jetty.xml to add XFF handler customization

## 2020/Oct/12 - bld2010121020
    - fix footer links to use https:
    - updated Jetty to 9.4.32
    - removed old copy of etc/jetty.xml

## 2020/Sep/14 - bld2009141049
    - replace sysnews urls for password changes

## 2020/Aug/10 - bld2008101324
    - updated Java 11 from Amazon
    - updated Jetty to 9.4.31

## 2020/Jul/29 - bld2007291143
    - duo link changes
    - footer changes

## 2020/Jul/01-13:04 - bld2007011304
    - update to Jetty 9.4.30
    - added downloads / make java_version (not really needed)

## 2020/Jun/08-10:51 - bld2006081051
    - update CentOS 7.8 base
    - update Jetty to 9.4.29

## 2020/Jun/03-14:01 - bld2006031401
    - update to IdP 4.0.1
    - fix audit.xml logging
    - fix sealer key script

## 2020/May/08-09:27 - bld2005080927
    - update Jetty to 9.4.28
    - update to OpenJDK 1.8.0_252

## 2020/Apr/30-12:58 - bld2004301258
    - update default views to unity/brickyard theme

## 2020/Apr/27-12:50 - bld2004271250
    - fixed some deprecation warnings
    - updated jaas-ncsuadloginmodule-1.3.0-1.0.jar

## 2020/Apr/20-14:21 - bld2004201421
    - started conversion to IdP 4.0
    - installed Amazon Corretto Java 11
    - installed and successfully ran IdP 4.0.0 w/no configs

## 2020/Mar/09-09:56 - bld2003090956
    - update to Jetty 9.4.27

## 2020/Feb/10-13:31 - bld2002101331
    - update to OpenJDK 1.8.0_242
    - update to Jetty 9.4.26

## 2019/Dec/09-13:22 - bld1912091322
    - update to Jetty 9.4.24

## 2019/Nov/11-09:41 - bld1911110941
    - update to Jetty 9.4.22

## 2019/Nov/01-13:10 - bld1911011310
    - add jolokia-war-unsecured to kit
    - update to OpenJDK 1.8.0_232

## 2019/Oct/07-10:17 - bld1910071017
    - update to Jetty 9.4.21
    - update to IdP 3.4.6

## 2019/Sep/09-10:50 - bld1909091050
    - update to CentOS base
    - update to Jetty 9.4.20

## 2019/Aug/12-08:42 - bld1908120842
    - edit Makefile to pass REBUILD flag
    - update to OpenJDK 1.8.0_222

## 2019/Jul/08-14:27 - bld1907081427
    - update to Jetty 9.4.19
    - removed Oracle Java 8 SE, replaced with RedHat OpenJDK 1.8.0_212
    - removed JCE policy - already present in latest OpenJDK builds

## 2019/May/06-08:57 - bld1905060857
    - update to Java 8u212, requires manual login and download
    - update to Jetty 9.4.18
    - update to IdP 3.4.4

## 2019/Mar/11-10:11 - bld1903111011
    - update to Jetty 9.4.15

## 2019/Feb/11-08:58 - bld1902110858
    - update to IdP 3.4.3
    - update to Java 8u202

## 2019/Jan/07-09:29 - bld1901070929
    - update to IdP 3.4.2

## 2018/Dec/10-09:01 - bld1812100901
    - update to centos 7.6 base
    - update to Jetty 9.4.14

## 2018/Nov/12-14:55 - bld1811121455
    - update to centos7 base, still 7.5
    - update to Java 8u192
    - fix changes to consent flow in 3.4.x

## 2018/Nov/02-09:46 - bld1811020946
    - changed image name to idp34-local-base
    - update to IdP 3.4.1
    - changed location of added jar files to edit-webapp

## 2018/Sep/18-08:36 - bld1809180836
    - restore RSA ciphers removed by default in jetty 9.4.12

## 2018/Sep/10-08:45 - bld1809100845
    - update to centos7 base
    - update to jetty 9.4.12

## 2018/Aug/06-09:06 - bld1808060906
    - update to Java 8u181
    - added handler for X-Forwarded-For logging

## 2018/Jun/27-09:40 - bld1806270940
    - fix logout iframe page to load logo correctly

## 2018/Jun/11-08:56 - bld1806110856
    - update to centos7 base
    - update to jetty 9.4.11
    - update to IdP 3.3.3

## 2018/Jun/01-10:40 - bld1806011040
    - added code to prevent selective attribute approvals
    - added error message for MFA required when user is not in duo

## 2018/May/07-09:41 - bld1805070941
    - update to centos7 base
    - update Java to 8u172

## 2018/Feb/12-10:24 - bld1802121024
    - update to centos7 base
    - update Java to 8u162

## 2017/Dec/11-10:25 - bld1712111025
    - update to centos7 base
    - update to Jetty 9.4.8.v20171121

## 2017/Nov/27-15:58 - bld1711271558
    - replace Duo blurb with 2FA blurb on sidebar
    - cleaned out html link rel duplication on bootstrap

## 2017/Nov/06-10:05 - bld1711061005
    - update to centos7 base
    - update Java to 8u152

## 2017/Oct/09-10:55 - bld1710091055
    - update to centos7 base
    - update to Jetty 9.4.7.v20170914
    - update to IdP 3.3.2
    - Java 9 released last month, will not update. still using 8u144

## 2017/Aug/14-16:29 - bld1708141629
    - added display of expDate in expiring-password page

## 2017/Aug/07-09:11 - bld1708070911
    - update to centos7 base
    - update Java to 8u144

## 2017/Aug/02-07:21 - bld1708020721
    - add NCSU CA certs to base
    - adds SHA256 version of NCSU CA cert, and combined file

## 2017/Jul/14-10:39 - bld1707141039
    - fix messages to re-add hook for AccountDisabled

## 2017/Jun/12-09:19 - bld1706120919
    - update Jetty to 9.4.6.v20170531

## 2017/Jun/06-10:20 - bld1706061020
    - docker image renamed to idp33-local-base
    - centos updates 
    - update Java to 8u131
    - update Jetty to 9.4.5.v20170502
    - deploying IdP 3.3.1 to production

## 2017/May/30-09:21 - bld1705300921
    - add Duo enrollment blurb to sidebar

## 2017/May/26-
    - removed duo_shibboleth.zip
    - added duo-client and support jars

## 2017/Apr/10-
    - update Jetty to 9.4.3.v20170317

## 2017/Apr/06-13:15 - bld1704061315
    - add panel-blue to style_301.css for duo views

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


