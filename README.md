# zabbix-cert-expiring-check

## Enabling External Check
Copy the `certexpirecheck.sh` script to the external scripts directory
  
## Configuration
1. Run `make edit` to add hosts (and ports if not 443)  
2. Run `make create` to build template  
3. Import `build/certcheck.xml` into Zabbix  

## Creating a screen
| Setting | Value |  
| --- | --- |  
| Resource |Trigger Overview |  
| Group | The group you entered at build |  
| Application | SSL Certificate Check |  
| Hosts Location | Top |  

  
Tested with Zabbix 3.2
