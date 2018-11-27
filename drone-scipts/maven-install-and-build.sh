#! /bin/bash
# https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html

sudo apt update
sudo apt-get -y install maven

mvn compile
mvn exec:java
mvn package