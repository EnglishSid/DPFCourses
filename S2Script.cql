// Run this first against an empty Neo4j instance
CREATE (p1:Person {name:'John'})
CREATE (p2:Person {name:'Rose'})
CREATE (p3:Person {name:'Linda'})
CREATE (p4:Person {name:'Frank'})
CREATE (p5:Person {name:'Susan'})

CREATE (c1:Course {name:'SAFe Agilist 5'})
CREATE (c2:Course {name:'SecOps 2021'})

CREATE (r1:Role {name:'Product Owner'})
CREATE (r2:Role {name:'Scrum Master'})
CREATE (r3:Role {name:'Developer'})

MERGE (p1)-[:PERFORMS]->(r1)
MERGE (p2)-[:PERFORMS]->(r1)
MERGE (p3)-[:PERFORMS]->(r1)
MERGE (p4)-[:PERFORMS]->(r2)
MERGE (p5)-[:PERFORMS]->(r3)

MERGE (p1)-[:RECOMMENDS {role:r1.name}]->(c1)
MERGE (p2)-[:RECOMMENDS {role:r1.name}]->(c1)
MERGE (p3)-[:RECOMMENDS {role:r1.name}]->(c1)
MERGE (p4)-[:RECOMMENDS {role:r2.name}]->(c1)
MERGE (p5)-[:RECOMMENDS {role:r3.name}]->(c1)
MERGE (p1)-[:RECOMMENDS {role:r1.name}]->(c2)
MERGE (p2)-[:RECOMMENDS {role:r1.name}]->(c2)
MERGE (p5)-[:RECOMMENDS {role:r3.name}]->(c2)

---

// Get all recommended courses for the role Product Owner

MATCH (c:Course)<-[rec:RECOMMENDS]-(p:Person)
WHERE rec.role ='Product Owner'
RETURN c.name, count (rec) as numberOfRecs


// Now move one of the existing Product Owners to a new role

MATCH (p:Person {name:'Linda'})-[r]-(:Role)
DELETE r
WITH p
MATCH (r:Role {name:'Developer'})
MERGE (p)-[:PERFORMS]->(r)

// The recommendations made when Linda was a Product Owner remain in place
// Option add a recommendation date and include this within the query

// Retun the query - result set remains the same.

MATCH (c:Course)<-[rec:RECOMMENDS]-(p:Person)
WHERE rec.role ='Product Owner'
RETURN c.name, count (rec) as numberOfRecs