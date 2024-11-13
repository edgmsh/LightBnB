insert into users (
 name ,
  email ,
  password 
) values
('Ed', 'ed@gmail.com','$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'),
('Mia', 'mia@gmail.com','$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'),
('Nika', 'nika@gmail.com','$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'),
('Stella', 'stella@gmail.com','$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u');

insert into properties (
  owner_id ,
  title ,
  description ,
  thumbnail_photo_url ,
  cover_photo_url ,
  cost_per_night ,
  parking_spaces ,
  number_of_bathrooms ,
  number_of_bedrooms ,
  country ,
  street ,
  city ,
  province ,
  post_code ,
  active 
) values
(1,'Speed lamp', 'description','https://images.pexels.com/photos/2086676/pexels-photo-2086676.jpeg?auto=compress&cs=tinysrgb&h=350','https://images.pexels.com/photos/2086676/pexels-photo-2086676.jpeg', 93061,6,4,8, 'Canada','536 Namsub Highway','Sotboske', 'Quebec','K2S0U7',true),
(1,'Speed lamp', 'description','https://images.pexels.com/photos/2121121/pexels-photo-2121121.jpeg?auto=compress&cs=tinysrgb&h=350','https://images.pexels.com/photos/2121121/pexels-photo-2121121.jpeg', 85234,6,6,7, 'Canada','651 Nami Road ','Bohbatev', 'Alberta','M2M6A1',true),
(2,'Habit mix', 'description','https://images.pexels.com/photos/2080018/pexels-photo-2080018.jpeg?auto=compress&cs=tinysrgb&h=350','https://images.pexels.com/photos/2080018/pexels-photo-2080018.jpeg', 93061,0,5,6, 'Canada','1650 Hejto Center ','Genwezuj', 'Newfoundland And Labrador','A1Z8Y6',true);


insert into reservations (
  start_date,
  end_date,
  property_id,
  guest_id 
) values
('2024-09-11','2024-09-26',2,3),
('2024-01-04','2024-02-01',2,2),
('2024-10-01','2024-10-14',1,3);

insert into property_reviews (
  guest_id ,
  property_id ,
  reservation_id ,
  rating ,
  message  
) values
(3,2,1,3,'message'),
(2,2,2,4,'message'),
(3,1,3,4,'message');

