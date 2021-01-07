# Create a movie rental riak key-value store
# (bucket = movies), (values = releasedate,runningtime,genre)

# 1) Add 6 movies to the database

curl -v -X PUT http://riak:8098/riak/movies/Interstellar \
-H "Content-Type:application/json" \
-d '{"releasedate":"2014","runningtime":"2h49min","genre":"Sci-Fi"}'

curl -v -X PUT http://riak:8098/riak/movies/InsideOut \
-H "Content-Type:application/json" \
-d '{"releasedate":"2015","runningtime":"1h35min","genre":"Animation"}'

curl -v -X PUT http://riak:8098/riak/movies/MyFatherAndMySon \
-H "Content-Type:application/json" \
-d '{"releasedate":"2005","runningtime":"1h52min","genre":"Drama"}'

curl -v -X PUT http://riak:8098/riak/movies/Room \
-H "Content-Type:application/json" \
-d '{"releasedate":"2015","runningtime":"1h58min","genre":"Drama"}'

curl -v -X PUT http://riak:8098/riak/movies/TrainToBusan \
-H "Content-Type:application/json" \
-d '{"releasedate":"2016","runningtime":"1h58min","genre":"Action"}'

curl -v -X PUT http://riak:8098/riak/movies/MurderMystery \
-H "Content-Type:application/json" \
-d '{"releasedate":"2019","runningtime":"1h37min","genre":"Comedy"}'

# 2) Delete one of the movie records.

curl -i -X DELETE http://riak:8098/riak/movies/Room 

# 3) Create 3 branches -> East-West-South
# (bucket=branches),(values=East,West,South)
# Link each of the remaining five movies to at least one of the branches. 
# (riaktag=holds)

curl -X PUT http://riak:8098/riak/branches/East \
-H "Content-Type:application/json" \
-H "Link:</riak/movies/Interstellar>;riaktag=\"holds\", </riak/movies/MyFatherAndMySon>;riaktag=\"holds\"" \
-d '{"branchName":"East"}'

curl -X PUT http://riak:8098/riak/branches/West \
-H "Content-Type:application/json" \
-H "Link:</riak/movies/InsideOut>;riaktag=\"holds\", </riak/movies/TrainToBusan>;riaktag=\"holds\"" \
-d '{"branchName":"West"}'

curl -X PUT http://riak:8098/riak/branches/South \
-H "Content-Type:application/json" \
-H "Link:</riak/movies/MurderMystery>;riaktag=\"holds\", </riak/movies/InsideOut>;riaktag=\"holds\"" \
-d '{"branchName":"South"}'

# 4) Download a movie picture.
# Add it to a bucket named images with the key being the picture name and then link it to the movie.

curl -X PUT http://riak:8098/riak/images/traintobusan.jpeg \
-H "Content-Type:application/json" \
-H "Link:</riak/movies/TrainToBusan>;riaktag=\"photo\"" \
--data-binary @traintobusan.jpeg

# 5) Run queries listing :
# All the buckets

curl -i http://riak:8098/riak?buckets=true

# All the movies found in each branch

curl -i http://riak:8098/riak/branches/East/movies,_,_
curl -i http://riak:8098/riak/branches/West/movies,_,_
curl -i http://riak:8098/riak/branches/South/movies,_,_


# The movie with the picture and its branch. (Will be show Location: /riak/movies/TrainToBusan)

curl http://riak:8098/riak/images/traintobusan.jpeg/movies,_,_



# 6) The hostname in the file should be changed to http://riak:8098/riak/
