foo=$(hostname)

rm /tmp/dcs_dump/*.*
rmdir /tmp/dcs_dump
mkdir /tmp/dcs_dump

sqlite3 -header -csv /mnt/ybdata/ybdb/ybcm.db "
SELECT  '${foo}' AS sys_id, version, yb_chassis_version, datetime() as inv_date FROM version;
" > /tmp/dcs_dump/${foo}.dcs_version.csv

sqlite3 -header -csv /mnt/ybdata/ybdb/ybcm.db "
SELECT  '${foo}' AS sys_id, fru_type , name AS item_name , fru_part_number , fru_serial_number , fru_mfg_date , oil_version , platform_system , os_version , datetime(created_on) as created_on, datetime(last_updated) as last_updated, datetime('now') as inv_date, tenant_id , cluster_id FROM yb_cmp;  
" > /tmp/dcs_dump/${foo}.dcs_yb_cmp.csv

sqlite3 -header -csv /mnt/ybdata/ybdb/ybcm.db "
SELECT  '${foo}' AS sys_id, chassis_name  , chassis_id  , primary_ip_address  , secondary_ip_address  , datetime(created_on) as created_on, datetime(last_updated) as last_updated, datetime('now') as inv_date, tenant_id  , cluster_id FROM yb_chassis;
" > /tmp/dcs_dump/${foo}.dcs_yb_chassis.csv

sqlite3 -header -csv /mnt/ybdata/ybdb/ybcm.db "
SELECT  '${foo}' AS sys_id, chassis_id , fru_type , name AS item_name , fru_part_number , fru_serial_number , fru_mfg_date , oil_version , platform_system , mac_address , LOWER(uuid) as uuid, blade_bay , datetime(blade_state_timestamp) as blade_state_timestamp  , datetime(created_on) as created_on, datetime(last_updated) as last_updated, datetime('now') as inv_date, tenant_id , cluster_id FROM yb_blade;
" > /tmp/dcs_dump/${foo}.dcs_yb_blade.csv

sqlite3 -header -csv /mnt/ybdata/ybdb/ybcm.db "
SELECT  '${foo}' AS sys_id, worker_id , driver_name , serial_number , model_name , firmware_version , drive_num , address  , datetime(created_on) as created_on, datetime(last_updated) as last_updated, datetime('now') as inv_date, tenant_id , cluster_id FROM yb_drives; 
" > /tmp/dcs_dump/${foo}.dcs_yb_drives.csv

sqlite3 -header -csv /mnt/ybdata/ybdb/ybcm.db "
SELECT  '${foo}' AS sys_id, chassis_id , fru_type , name AS item_name , fru_part_number , fru_serial_number , fru_mfg_date , oil_version , platform_system , datetime(created_on) as created_on, datetime(last_updated) as last_updated, datetime('now') as inv_date, tenant_id , cluster_id FROM yb_fan;
" > /tmp/dcs_dump/${foo}.dcs_yb_fan.csv

sqlite3 -header -csv /mnt/ybdata/ybdb/ybcm.db "
SELECT  '${foo}' AS sys_id, chassis_id , fru_type , name AS item_name , fru_part_number , fru_serial_number , fru_mfg_date , oil_version , platform_system , datetime(created_on) as created_on, datetime(last_updated) as last_updated, datetime('now') as inv_date, tenant_id , cluster_id  FROM yb_psu;
" > /tmp/dcs_dump/${foo}.dcs_yb_psu.csv

sqlite3 -header -csv /mnt/ybdata/ybdb/ybcm.db "
SELECT  '${foo}' AS sys_id, chassis_id , fru_type , name AS item_name , fru_part_number , fru_serial_number , fru_mfg_date , oil_version , platform_system , datetime(created_on) as created_on, datetime(last_updated) as last_updated, datetime('now') as inv_date, tenant_id , cluster_id FROM yb_panel;
" > /tmp/dcs_dump/${foo}.dcs_yb_panel.csv

sqlite3 -header -csv /mnt/ybdata/ybdb/ybcm.db "
SELECT  '${foo}' AS sys_id, leader_name , device_name , device_model , device_serial_number , device_firmware_version , capacity , datetime(created_on) as created_on, datetime(last_updated) as last_updated, datetime('now') as inv_date, tenant_id , cluster_id  FROM yb_nvme;
" > /tmp/dcs_dump/${foo}.dcs_yb_nvme.csv

sqlite3 -header -csv /mnt/ybdata/ybdb/ybcm.db "
SELECT  '${foo}' AS sys_id, name AS item_name, hostname, cmp_ip_address, bios_version, ybd_software_version, datetime(created_on) as created_on, datetime(last_updated) as last_updated, datetime('now') as inv_date, tenant_id, cluster_id FROM yb_leader;
" > /tmp/dcs_dump/${foo}.dcs_yb_leader.csv

ybcli system info get | tee /tmp/dcs_dump/${foo}.ybcli_system_info_read.txt
