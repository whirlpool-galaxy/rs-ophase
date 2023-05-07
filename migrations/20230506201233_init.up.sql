-- Add up migration script here

-- `rs-ophase`.building definition

CREATE TABLE `building` (
  `id` int(11) NOT NULL,
  `building` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `buildings_UN` (`building`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- `rs-ophase`.erstie definition

CREATE TABLE `erstie` (
  `erstie_code` varchar(48) NOT NULL,
  `pwd_hash` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`erstie_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- `rs-ophase`.`group` definition

CREATE TABLE `group` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `max_capacity` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- `rs-ophase`.`role` definition

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- `rs-ophase`.schedule definition

CREATE TABLE `schedule` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `begin` datetime NOT NULL,
  `end` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- `rs-ophase`.`user` definition

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `prefered_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `pwd_hash` varchar(100) DEFAULT NULL,
  `sso_connection_code` varchar(48) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_UN` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- `rs-ophase`.group_member definition

CREATE TABLE `group_member` (
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`group_id`),
  KEY `group_member_FK_1` (`group_id`),
  CONSTRAINT `group_member_FK` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `group_member_FK_1` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- `rs-ophase`.group_member_num definition

CREATE TABLE `group_member_num` (
  `group_id` int(11) NOT NULL,
  `day` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`group_id`,`day`),
  CONSTRAINT `group_member_num_FK` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- `rs-ophase`.room definition

CREATE TABLE `room` (
  `id` int(11) NOT NULL,
  `building_id` int(11) NOT NULL,
  `room` varchar(100) NOT NULL,
  `capacity` int(10) unsigned NOT NULL DEFAULT 1,
  `beamer` tinyint(1) NOT NULL DEFAULT 0,
  `group` tinyint(1) NOT NULL DEFAULT 0,
  `workshop` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rooms_UN` (`building_id`,`room`),
  CONSTRAINT `rooms_FK` FOREIGN KEY (`building_id`) REFERENCES `building` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- `rs-ophase`.room_reserved definition

CREATE TABLE `room_reserved` (
  `id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `begin` datetime NOT NULL,
  `end` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `room_reserved_UN` (`room_id`,`begin`,`end`),
  CONSTRAINT `room_reserved_FK` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- `rs-ophase`.user_in_role definition

CREATE TABLE `user_in_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `user_in_role_FK_0` (`role_id`),
  CONSTRAINT `user_in_role_FK_0` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `user_in_role_FK_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- `rs-ophase`.workshop definition

CREATE TABLE `workshop` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `requirements_erstie` text NOT NULL,
  `requirements` text NOT NULL,
  `max_participants` int(11) DEFAULT NULL,
  `beamer` tinyint(1) NOT NULL DEFAULT 1,
  `approved` tinyint(1) NOT NULL DEFAULT 0,
  `schedule_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `workshop_FK` (`owner`),
  KEY `workshop_FK_1` (`schedule_id`),
  KEY `workshop_FK_2` (`room_id`),
  CONSTRAINT `workshop_FK` FOREIGN KEY (`owner`) REFERENCES `user` (`id`),
  CONSTRAINT `workshop_FK_1` FOREIGN KEY (`schedule_id`) REFERENCES `schedule` (`id`),
  CONSTRAINT `workshop_FK_2` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- `rs-ophase`.workshop_time_restraint definition

CREATE TABLE `workshop_time_restraint` (
  `workshop_id` int(11) NOT NULL,
  `schedule_id` int(11) NOT NULL,
  PRIMARY KEY (`workshop_id`,`schedule_id`),
  KEY `workshop_time_restraint_FK_1` (`schedule_id`),
  CONSTRAINT `workshop_time_restraint_FK_0` FOREIGN KEY (`workshop_id`) REFERENCES `workshop` (`id`),
  CONSTRAINT `workshop_time_restraint_FK_1` FOREIGN KEY (`schedule_id`) REFERENCES `schedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- `rs-ophase`.workshop_user_restraint definition

CREATE TABLE `workshop_user_restraint` (
  `workshop_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`workshop_id`,`user_id`),
  KEY `workshop_user_restraint_FK_0` (`user_id`),
  CONSTRAINT `workshop_user_restraint_FK_0` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `workshop_user_restraint_FK_1` FOREIGN KEY (`workshop_id`) REFERENCES `workshop` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- `rs-ophase`.erstie_workshop_result_cache definition

CREATE TABLE `erstie_workshop_result_cache` (
  `erstie_code` varchar(48) NOT NULL,
  `workshop_id` int(11) NOT NULL,
  PRIMARY KEY (`erstie_code`,`workshop_id`),
  KEY `erstie_workshop_result_cache_FK_1` (`workshop_id`),
  CONSTRAINT `erstie_workshop_result_cache_FK_0` FOREIGN KEY (`erstie_code`) REFERENCES `erstie` (`erstie_code`),
  CONSTRAINT `erstie_workshop_result_cache_FK_1` FOREIGN KEY (`workshop_id`) REFERENCES `workshop` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- `rs-ophase`.group_in_room definition

CREATE TABLE `group_in_room` (
  `group_id` int(11) NOT NULL,
  `schedule_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  PRIMARY KEY (`group_id`,`schedule_id`,`room_id`),
  KEY `group_in_room_FK_0` (`room_id`),
  KEY `group_in_room_FK_2` (`schedule_id`),
  CONSTRAINT `group_in_room_FK_0` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`),
  CONSTRAINT `group_in_room_FK_1` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`),
  CONSTRAINT `group_in_room_FK_2` FOREIGN KEY (`schedule_id`) REFERENCES `schedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- `rs-ophase`.selected_priority definition

CREATE TABLE `selected_priority` (
  `erstie_code` varchar(48) NOT NULL,
  `workshop_id` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  PRIMARY KEY (`erstie_code`,`workshop_id`,`priority`),
  KEY `selected_priority_FK_1` (`workshop_id`),
  CONSTRAINT `selected_priority_FK_0` FOREIGN KEY (`erstie_code`) REFERENCES `erstie` (`erstie_code`),
  CONSTRAINT `selected_priority_FK_1` FOREIGN KEY (`workshop_id`) REFERENCES `workshop` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;