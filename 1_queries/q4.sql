select properties.city, count(reservations.*) from properties
join reservations on reservations.property_id = properties.id
group by properties.city
order by count(reservations.*) desc;