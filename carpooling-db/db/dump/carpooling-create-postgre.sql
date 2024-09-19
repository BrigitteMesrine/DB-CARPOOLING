CREATE TABLE user_(
   id SERIAL,
   last_name VARCHAR(30)  NOT NULL,
   first_name VARCHAR(30)  NOT NULL,
   email VARCHAR(50)  NOT NULL,
   phone VARCHAR(20)  NOT NULL,
   password VARCHAR(255)  NOT NULL,
   img VARCHAR(255) ,
   is_active BOOLEAN NOT NULL DEFAULT false,
   has_vehicle BOOLEAN NOT NULL DEFAULT false,
   PRIMARY KEY(id),
   UNIQUE(email),
   UNIQUE(phone)
);

CREATE TABLE session(
   id SERIAL,
   start_date_ DATE,
   end_date_ DATE,
   PRIMARY KEY(id)
);

CREATE TABLE role_(
   id SERIAL,
   name_ VARCHAR(50)  NOT NULL,
   can_be_admin BOOLEAN NOT NULL DEFAULT false,
   PRIMARY KEY(id),
   UNIQUE(name_)
);

CREATE TABLE center(
   id SERIAL,
   opening_hour TIME NOT NULL,
   closing_hour TIME NOT NULL,
   address_ VARCHAR(255)  NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(address_)
);

CREATE TABLE fuel(
   id SERIAL,
   type_ VARCHAR(50)  NOT NULL,
   price_per_unit NUMERIC(15,2)   NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(type_)
);

CREATE TABLE vehicle_type(
   id SERIAL,
   name_ VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(name_)
);

CREATE TABLE intern(
   id SERIAL,
   center_id INTEGER NOT NULL,
   session_id INTEGER NOT NULL,
   user_id INTEGER NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(user_id),
   FOREIGN KEY(center_id) REFERENCES center(id),
   FOREIGN KEY(session_id) REFERENCES session(id),
   FOREIGN KEY(user_id) REFERENCES user_(id)
);

CREATE TABLE employee(
   id SERIAL,
   contract_start_date DATE,
   contract_end_date DATE,
   is_admin BOOLEAN DEFAULT false,
   role_id INTEGER NOT NULL,
   user_id INTEGER NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(user_id),
   FOREIGN KEY(role_id) REFERENCES role_(id),
   FOREIGN KEY(user_id) REFERENCES user_(id)
);

CREATE TABLE vehicle(
   id SERIAL,
   seats SMALLINT NOT NULL,
   brand VARCHAR(50)  NOT NULL,
   model VARCHAR(50)  NOT NULL,
   registration_number VARCHAR(50)  NOT NULL,
   vehicle_type_id INTEGER NOT NULL,
   owner_id INTEGER NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(vehicle_type_id) REFERENCES vehicle_type(id),
   FOREIGN KEY(owner_id) REFERENCES user_(id)
);

CREATE TABLE course(
   id SERIAL,
   name_ VARCHAR(255) ,
   referent_id INTEGER NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(name_),
   FOREIGN KEY(referent_id) REFERENCES employee(id)
);

CREATE TABLE route(
   id SERIAL,
   departure_address VARCHAR(255)  NOT NULL,
   departure_time_approx TIME DEFAULT current_time,
   departure_date DATE DEFAULT current_date,
   arrival_address VARCHAR(255)  NOT NULL,
   price NUMERIC(15,2)  ,
   is_regular BOOLEAN NOT NULL DEFAULT false,
   route_description VARCHAR(255) ,
   day_range JSON,
   user_id INTEGER NOT NULL,
   vehicle_id INTEGER NOT NULL,
   driver_id INTEGER NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(user_id) REFERENCES user_(id),
   FOREIGN KEY(vehicle_id) REFERENCES vehicle(id),
   FOREIGN KEY(driver_id) REFERENCES user_(id)
);

CREATE TABLE comment(
   id SERIAL,
   text VARCHAR(255) ,
   route_id INTEGER NOT NULL,
   user_id INTEGER NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(route_id) REFERENCES route(id),
   FOREIGN KEY(user_id) REFERENCES user_(id)
);

CREATE TABLE request(
   id SERIAL,
   is_validated BOOLEAN NOT NULL DEFAULT false,
   user_id INTEGER NOT NULL,
   route_id INTEGER NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(user_id) REFERENCES user_(id),
   FOREIGN KEY(route_id) REFERENCES route(id)
);

CREATE TABLE gcu(
   id SERIAL,
   text_ TEXT NOT NULL,
   PRIMARY KEY(id)
);

CREATE TABLE notification(
   id SERIAL,
   type_ VARCHAR(50) ,
   default_text TEXT,
   timestamp_ TIMESTAMP,
   user_id INTEGER,
   PRIMARY KEY(id),
   FOREIGN KEY(user_id) REFERENCES user_(id)
);

CREATE TABLE teacher_session(
   teacher_id INTEGER,
   session_id INTEGER,
   PRIMARY KEY(teacher_id, session_id),
   FOREIGN KEY(teacher_id) REFERENCES employee(id),
   FOREIGN KEY(session_id) REFERENCES session(id)
);

CREATE TABLE passenger_route(
   passenger_id INTEGER,
   route_id INTEGER,
   PRIMARY KEY(passenger_id, route_id),
   FOREIGN KEY(passenger_id) REFERENCES user_(id),
   FOREIGN KEY(route_id) REFERENCES route(id)
);

CREATE TABLE employee_center(
   employee_id INTEGER,
   center_id INTEGER,
   PRIMARY KEY(employee_id, center_id),
   FOREIGN KEY(employee_id) REFERENCES employee(id),
   FOREIGN KEY(center_id) REFERENCES center(id)
);

CREATE TABLE session_center(
   session_id INTEGER,
   center_id INTEGER,
   PRIMARY KEY(session_id, center_id),
   FOREIGN KEY(session_id) REFERENCES session(id),
   FOREIGN KEY(center_id) REFERENCES center(id)
);

CREATE TABLE course_session(
   session_id INTEGER,
   course_id INTEGER,
   PRIMARY KEY(session_id, course_id),
   FOREIGN KEY(session_id) REFERENCES session(id),
   FOREIGN KEY(course_id) REFERENCES course(id)
);

CREATE TABLE vehicleType_fuel(
   fuel_type INTEGER,
   vehicle_type INTEGER,
   consumption NUMERIC(15,2)   NOT NULL,
   PRIMARY KEY(fuel_type, vehicle_type),
   FOREIGN KEY(fuel_type) REFERENCES fuel(id),
   FOREIGN KEY(vehicle_type) REFERENCES vehicle_type(id)
);

CREATE TABLE user_notification(
   user_id INTEGER,
   notification_id INTEGER,
   is_app BOOLEAN NOT NULL DEFAULT true,
   is_email BOOLEAN NOT NULL DEFAULT true,
   is_phone BOOLEAN NOT NULL DEFAULT false,
   PRIMARY KEY(user_id, notification_id),
   FOREIGN KEY(user_id) REFERENCES user_(id),
   FOREIGN KEY(notification_id) REFERENCES notification(id)
);

