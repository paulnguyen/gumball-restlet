
all: clean 

clean:
	rm -rf build/*
	rm -f dist/app.jar
	find . -name "*.class" -exec rm -rf {} \;

jar: compile
	cd build ; jar -cvfe ../dist/app.jar GumballServer .

test: compile app
	java -cp \
	dist/org.restlet-2.3.7.jar:\
	dist/org.restlet.ext.json-2.3.7.jar:\
	dist/json.jar:\
	dist/app.jar api.GumballServer

compile: 
	javac -cp \
	dist/org.restlet-2.3.7.jar:\
	dist/org.restlet.ext.json-2.3.7.jar:\
	dist/json.jar -d build \
	src/gumball/*.java \
	clients/loadtestclient/*.java \
	src/api/*.java

run: compile
	echo Starting Service at:  http://localhost:8080
	java -cp \
	dist/json.jar:\
	dist/org.restlet-2.3.7.jar:\
	dist/org.restlet.ext.json-2.3.7.jar:\
	build api.GumballServer

loadtest: compile
	echo Starting Load Test on localhost
	java -cp \
	dist/json.jar:\
	dist/org.restlet-2.3.7.jar:\
	dist/org.restlet.ext.json-2.3.7.jar:\
	build RunLoadTest 5

get:
	curl http://localhost:8080/v1/gumball

insert:
	curl -X POST http://localhost:8080/v1/gumball -d '{ "action": "insert-quarter" }'

crank:
	curl -X POST http://localhost:8080/v1/gumball -d '{ "action": "turn-crank" }'
	
