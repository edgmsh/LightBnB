select properties.id, title, cost_per_night, reservations.start_date, avg(property_reviews.rating)
from properties
join reservations on reservations.property_id = properties.id
join property_reviews on property_reviews.property_id = properties.id
where reservations.guest_id = (select id from users where email = 'tristanjacobs@gmail.com')
group by properties.id, reservations.start_date
order by reservations.start_date asc
limit 10;