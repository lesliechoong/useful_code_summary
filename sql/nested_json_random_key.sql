-- extract keys and values of a nested json
-- when to use it? -- the json keys is unknown, eg: {"12345":{"a":"1", "b":"2"}, {"1234":{"a":2}}, first layer of key is unknown



with t1 as 
(
    select 
        json_extract(json_parse(json_column), '$.entity_map') as entity_map -- entity_map is the json key that consists of nested column key
    from
	<table> 
    where
	<filter> 
)
select 
	key as json_keys,
	json_format(m.value) json_values
from t1
cross join unnest (map_keys(CAST(entity_map AS map<varchar,json>)), map_values(CAST(entity_map AS map<varchar,json>)) ) AS m(key, value) -- extract keys and values and explode it into different rows
