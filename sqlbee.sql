start transaction;

create database `sqlbee` collate=utf8_unicode_ci;
use `sqlbee`;

create table `api_log` (
  `api_log_id` int(10) unsigned not null auto_increment,
  `method` enum('get','post') not null,
  `endpoint` varchar(255) not null,
  `json_arguments` text not null,
  `response` mediumtext not null,
  `timestamp` timestamp not null default current_timestamp,
  `deleted` tinyint(1) not null default '0',
  primary key (`api_log_id`)
) engine=innodb default charset=utf8 collate=utf8_unicode_ci;

create table `error_log` (
  `error_log_id` int(10) unsigned not null auto_increment,
  `timestamp` timestamp not null default current_timestamp,
  `json_error` text not null,
  `deleted` tinyint(1) unsigned not null default '0',
  primary key (`error_log_id`)
) engine=innodb default charset=utf8 collate=utf8_unicode_ci;

create table `thermostat` (
  `thermostat_id` int(10) unsigned not null auto_increment,
  `identifier` varchar(255) not null,
  `name` varchar(255) not null,
  `connected` tinyint(1) not null,
  `thermostat_revision` varchar(255) not null,
  `alert_revision` varchar(255) not null,
  `runtime_revision` varchar(255) not null,
  `internal_revision` varchar(255) not null,
  `json_runtime` text,
  `json_extended_runtime` text,
  `json_electricity` text,
  `json_settings` text,
  `json_location` text,
  `json_program` text,
  `json_events` text,
  `json_device` text,
  `json_technician` text,
  `json_utility` text,
  `json_management` text,
  `json_alerts` text,
  `json_weather` text,
  `json_house_details` text,
  `json_oem_cfg` text,
  `json_equipment_status` text,
  `json_notification_settings` text,
  `json_privacy` text,
  `json_version` text,
  `json_remote_sensors` text,
  `json_audio` text,
  `deleted` tinyint(1) not null default '0',
  primary key (`thermostat_id`),
  unique key `identifier` (`identifier`)
) engine=innodb default charset=utf8 collate=utf8_unicode_ci;

create table `sensor` (
  `sensor_id` int(10) unsigned not null auto_increment,
  `thermostat_id` int(10) unsigned not null,
  `identifier` varchar(255) collate utf8_unicode_ci not null,
  `name` varchar(255) collate utf8_unicode_ci not null,
  `type` varchar(255) collate utf8_unicode_ci not null,
  `code` varchar(255) collate utf8_unicode_ci default null,
  `in_use` tinyint(1) not null,
  `json_capability` text collate utf8_unicode_ci not null,
  `deleted` tinyint(1) not null default '0',
  primary key (`sensor_id`),
  key `thermostat_id` (`thermostat_id`),
  constraint `sensor_ibfk_1` foreign key (`thermostat_id`) references `thermostat` (`thermostat_id`)
) engine=innodb default charset=utf8 collate=utf8_unicode_ci;

create table `runtime_report_thermostat` (
  `runtime_report_thermostat_id` int(10) unsigned not null auto_increment,
  `thermostat_id` int(10) unsigned not null,
  `timestamp` timestamp not null,
  `auxiliary_heat_1` int(10) unsigned default null,
  `auxiliary_heat_2` int(10) unsigned default null,
  `auxiliary_heat_3` int(10) unsigned default null,
  `compressor_cool_1` int(10) unsigned default null,
  `compressor_cool_2` int(10) unsigned default null,
  `compressor_heat_1` int(10) unsigned default null,
  `compressor_heat_2` int(10) unsigned default null,
  `dehumidifier` int(10) unsigned default null,
  `demand_management_offset` decimal(4,1) default null,
  `economizer` int(10) unsigned default null,
  `fan` int(10) unsigned default null,
  `humidifier` int(10) unsigned default null,
  `hvac_mode` varchar(255) default null,
  `outdoor_humidity` int(10) unsigned default null,
  `outdoor_temperature` decimal(4,1) default null,
  `sky` int(10) unsigned default null,
  `ventilator` int(10) unsigned default null,
  `wind` int(10) unsigned default null,
  `zone_average_temperature` decimal(4,1) default null,
  `zone_calendar_event` varchar(255) default null,
  `zone_climate` varchar(255) default null,
  `zone_cool_temperature` decimal(4,1) default null,
  `zone_heat_temperature` decimal(4,1) default null,
  `zone_humidity` int(10) unsigned default null,
  `zone_humidity_high` int(10) unsigned default null,
  `zone_humidity_low` int(10) unsigned default null,
  `zone_hvac_mode` varchar(255) default null,
  `zone_occupancy` int(10) unsigned default null,
  `deleted` tinyint(1) not null default '0',
  primary key (`runtime_report_thermostat_id`),
  unique key `thermostat_id_timestamp` (`thermostat_id`,`timestamp`),
  constraint `runtime_report_thermostat_ibfk_1` foreign key (`thermostat_id`) references `thermostat` (`thermostat_id`)
) engine=innodb default charset=utf8 collate=utf8_unicode_ci;

create table `runtime_report_sensor` (
  `runtime_report_sensor_id` int(10) unsigned not null auto_increment,
  `thermostat_id` int(10) unsigned not null,
  `sensor_id` int(10) unsigned not null,
  `timestamp` timestamp not null,
  `temperature` decimal(4,1) default null,
  `humidity` int(10) unsigned default null,
  `occupancy` tinyint(1) default null,
  `deleted` tinyint(1) not null default '0',
  primary key (`runtime_report_sensor_id`),
  unique key `sensor_id_timestamp` (`sensor_id`,`timestamp`),
  key `thermostat_id` (`thermostat_id`),
  constraint `runtime_report_sensor_ibfk_1` foreign key (`sensor_id`) references `sensor` (`sensor_id`),
  constraint `runtime_report_sensor_ibfk_2` foreign key (`thermostat_id`) references `thermostat` (`thermostat_id`)
) engine=innodb default charset=utf8 collate=utf8_unicode_ci;

create table `token` (
  `token_id` int(10) unsigned not null auto_increment,
  `access_token` char(32) not null,
  `refresh_token` char(32) not null,
  `timestamp` timestamp not null default current_timestamp,
  `deleted` tinyint(4) not null default '0',
  primary key (`token_id`)
) engine=innodb default charset=utf8 collate=utf8_unicode_ci;

commit;
