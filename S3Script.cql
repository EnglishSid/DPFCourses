// Add some user votes against courses

MATCH (p1:Person {name:'John'})
MATCH (p2:Person {name:'Rose'})
MATCH (p3:Person {name:'Linda'})
MATCH (p4:Person {name:'Frank'})
MATCH (p5:Person {name:'Susan'})

MATCH (c1:Course {name:'SAFe Agilist 5'})
MATCH (c2:Course {name:'SecOps 2021'})

MERGE (p1)-[:VOTES {value:-1,role:'Product Owner'}]->(c1)
MERGE (p2)-[:VOTES {value:1,role:'Product Owner'}]->(c1)
MERGE (p3)-[:VOTES {value:1,role:'Product Owner'}]->(c1)
MERGE (p4)-[:VOTES {value:1,role:'Scrum Master'}]->(c1)
MERGE (p5)-[:VOTES {value:1,role:'Developer'}]->(c1)


//