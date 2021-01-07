//Your Neo4j code goes here

CREATE (Basak:Family {name: 'Basak Deniz', born: 1990}),
(Mustafa: Family {name: 'Mustafa Uslu', born: 1970}),
(Mehmet: Family {name: 'Mehmet Bahce', born: 1992}),
(Ali: Family {name: 'Ali Firtina', born: 2000}),
(Ayse : Family {name: 'Ayse Firtina', born: 2005}),
(Fatma: Family {name: 'Fatma Uslu', born: 1975}),
(Cecile: Family {name: 'Cecile Firtina', born: 1965}),
(Altay: Family {name: 'Altay Firtina', born: 1960}),
(Elmas:Family {name: 'Elmas Deniz', born: 1955})

CREATE (Cecile)-[:SPOUSE {married:1990}]->(Altay),
(Altay)-[:SPOUSE {married:1990}]->(Cecile),
(Altay)-[:CHILD {type:'son'}]->(Ali), 
(Cecile)-[:CHILD {type:'son'}]->(Ali),
(Altay)-[:CHILD {type:'daughter'}]->(Ayse),
(Cecile)-[:CHILD {type:'daughter'}]->(Ayse),
(Basak)-[:PARENT {type:'mother'}]->(Elmas),
(Ali)-[:PARENT {type:'father'}]->(Altay),
(Ali)-[:PARENT {type:'mother'}]->(Cecile),
(Ayse)-[:PARENT {type:'father'}]->(Altay),
(Ayse)-[:PARENT {type:'mother'}]->(Cecile),
(Mustafa)-[:SPOUSE {married:2000}]->(Fatma),
(Fatma)-[:SPOUSE {married:2000}]->(Mustafa),
(Mehmet)-[:SPOUSE {married:2017}]->(Basak),
(Basak)-[:SPOUSE {married:2017}]->(Mehmet),
(Ayse)-[:SIBLING]->(Ali),
(Altay)-[:SIBLING]->(Elmas),
(Mehmet)-[:PARENT {type:'mother'}]->(Fatma)
;
