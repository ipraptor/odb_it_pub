# Сетевые порты Check Point

Помимо перечисленных портов, в программном обеспечении Check Point используются известные порты TCP для FTP (20 and 21), SMTP (25), HTTP (80) and HTTPS (443), а также некоторые UDP порты

# Security Management Server

|	Протокол	|	Номер порта	|	Имя сервиса и комментарий										|	Назначение	|
| --------		| --------		| --------													| --------		|
|	TCP		|	258		|	‘FW1_mgmt’ — Check Point Security Management (Version 4.x)						|	Communication between SmartConsole applications and Security Management Server (by FWM daemon)	|
|	TCP		|	8989		|	not predefined												|	Loopback port (used by CPD process). Used only on Provider-1 Customer Management Add-on (CMA) / Domain Management Server for Session Authentication — CAPS Messaging (MSG_DEFAULT_PORT)	|
|	TCP		|	18184		|	‘FW1_lea’ — Check Point OPSEC Log Export API								|	Exporting FireWall logs by OPSEC products from Security Management Server (by FWD daemon)	|
|	TCP		|	18185		|	‘FW1_omi’ — Check Point OPSEC Objects Management Interface						|	Protocol used by applications having access to the ruleset saved on Security Management Server	|
|	TCP		|	18186		|	‘FW1_omi-sic’ — Check Point OPSEC Objects Management Interface with Secure Internal Communication (SIC)	|	Secure Internal Communication (SIC) between OPSEC certified products and Security Gateway	|
|	TCP		|	18187		|	‘FW1_ela’ — Check Point OPSEC Event Logging API								|	Sending FireWall logs by OPSEC products to Security Management Server (to FWD daemon)	|
|	TCP		|	18190		|	‘CPMI’ — Check Point Management Interface								|	Used by the FireWall Management process (FWM) to listen for Management Clients attempting to connect to the management module: Protocol used for Communication between the SmartConsole and the Security Management Server & Protocol for connections from Multi-Domain GUI to MDS and CMA / Domain	|
|	TCP		|	18202		|	‘CP_rtm’ — Check Point Real Time Monitoring								|	Loopback port (used by RTM process). SmartView Monitor	|
|	TCP		|	18209		|	not predefined												|	SIC communication (status, issue, revoke) between the Security Management Server (the Internal Certificate Authority (ICA)) and objects managed by this Security Management Sever (Security Gateways, OPSEC applications, etc.) (by FWM daemon)	|
|	TCP		|	18210		|	‘FW1_ica_pull’ — Check Point Internal CA Pull Certificate Service					|	Pulling certificates by Security Gateway from Security Management Sever (ICA_PULL, FWCA_PULL_PORT) (by CPCA daemon)	|
|	TCP		|	18211		|	‘FW1_ica_push’ — Check Point Internal CA Push Certificate Service					|	Pushing certificates from the Internal Certificate Authority (ICA) on Security Management Sever (by CPD daemon) to Security Gateway	|
|	TCP		|	18221		|	‘CP_redundant’ — Check Point Redundant Management Protocol						|	Synchronization between Primary and Secondary Security Management Severs / Customer Management Add-ons (CMAs) / Domain Management Servers (by FWM daemon)	|
|	TCP		|	18241		|	‘E2ECP’ — Check Point End to End Control Protocol							|	Loopback port (used by RTM process). Checking SLA’s defined in Virtual Links by SmartView Monitor	|
|	TCP		|	18265		|	‘FW1_ica_mgmt_tools’ — Check Point Internal CA Management Tools						|	Managing the ICA and central administration of Internal Certificate Authority (ICA) on the Security Management Server & Needs to be started separately with the Security Management Server andcpca_client	|
| --------		| --------		| --------													| --------	|

# Firewall

|	Протокол	|	Протокол	|	Номер порта	|	Имя сервиса и комментарий	|	Назначение	|
|	--------	|		--------|		--------|		--------|		--------|
|		|		|		|		|		|
|	TCP	|	TCP	|	256	|	‘FW1’ — Check Point Security Gateway Service	|	Communication between SmartConsole applications and Security Management Server (by FWM daemon)	|
|	TCP	|	TCP	|	257	|	‘FW1_log’ — Check Point Security Gateway Logs	|	Loopback port (used by CPD process). Used only on Provider-1 Customer Management Add-on (CMA) / Domain Management Server for Session Authentication — CAPS Messaging (MSG_DEFAULT_PORT)	|
|	TCP	|	TCP	|	259	|	‘FW1_clntauth_telnet’ — Check Point Security Gateway Client Authentication (Telnet)	|	Exporting FireWall logs by OPSEC products from Security Management Server (by FWD daemon)	|
|	TCP	|	UDP	|	260	|	‘FW1_snmp’ — Check Point Security Gateway SNMP Agent	|	Protocol used by applications having access to the ruleset saved on Security Management Server	|
|	TCP	|	TCP	|	261	|	‘FW1_snauth’ — Check Point Security Gateway Session Authentication	|	Secure Internal Communication (SIC) between OPSEC certified products and Security Gateway	|
|	TCP	|	TCP	|	262	|	not predefined	|	Sending FireWall logs by OPSEC products to Security Management Server (to FWD daemon)	|
|	TCP	|	"TCP	|	900	|	‘FW1_clntauth_http’ — Check Point Security Gateway Client Authentication (HTTP)	|	Used by the FireWall Management process (FWM) to listen for Management Clients attempting to connect to the management module:Protocol used for Communication between the SmartConsole and the Security Management Server Protocol for connections from Multi-Domain GUI to MDS and CMA / Domain"	|
|	TCP	|	TCP	|	4532	|	not predefined	|	Loopback port (used by RTM process). SmartView Monitor	|
|	TCP	|	UDP	|	5004	|	‘MetaIP-UAT’ — Check Point Meta IP UAM Client-Server Communication	|	SIC communication (status, issue, revoke) between the Security Management Server (the Internal Certificate Authority (ICA)) and objects managed by this Security Management Sever (Security Gateways, OPSEC applications, etc.) (by FWM daemon)	|
|	TCP	|	TCP	|	18183	|	‘FW1_sam’ — Check Point OPSEC Suspicious Activity Monitor API	|	Pulling certificates by Security Gateway from Security Management Sever (ICA_PULL, FWCA_PULL_PORT) (by CPCA daemon)	|
|	TCP	|	UDP	|	18212	|	‘FW1_load_agent’ — Check Point ConnectControl Load Agent	|	Pushing certificates from the Internal Certificate Authority (ICA) on Security Management Sever (by CPD daemon) to Security Gateway	|
|	TCP	|	TCP	|	18190	|	‘FW1_netso’ — Check Point User Authority simple protocol	|	Synchronization between Primary and Secondary Security Management Severs / Customer Management Add-ons (CMAs) / Domain Management Servers (by FWM daemon)	|
|	TCP	|	TCP	|	19191	|	‘FW1_uaa’ — Check Point OPSEC User Authority API	|	Loopback port (used by RTM process). Checking SLA’s defined in Virtual Links by SmartView Monitor	|
|	TCP	|	UDP	|	19194 & 19195	|	‘CP_SecureAgent-udp’ — SecureAgent Authentication service	|	Managing the ICA and central administration of Internal Certificate Authority (ICA) on the Security Management Server Needs to be started separately with the Security Management Server andcpca_client	|


