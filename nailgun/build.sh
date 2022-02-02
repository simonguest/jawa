cd /nailgun
make
mvn clean install

cp /nailgun/nailgun-server/target/nailgun-server-1.0.1.jar /output
cp /nailgun/nailgun-client/target/ng /output