select properties.id, title, cost_per_night, avg(property_reviews.rating) 
from properties
join property_reviews on property_reviews.property_id = properties.id and property_reviews.rating >= 4
where city = 'Vancouver' 
group by properties.id
order by cost_per_night asc
limit 10;