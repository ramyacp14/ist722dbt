with stg_artists as 
(
    select
        artist_id,
        artist_name,
        no_of_tracks
    from {{ source('vision','Artists') }}
),
stg_followers as
(
    select
        artist_id, ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS artist_rank
    from {{ source('vision', 'Followers') }}
    GROUP BY artist_id

)

select  
sl.artist_rank, st.artist_id, st.artist_name, st.no_of_tracks
from stg_artists st
JOIN stg_followers sl
ON st.artist_id = sl.artist_id