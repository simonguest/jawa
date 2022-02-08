cd /nailgun
make
mvn clean install

mkdir -p /output/build
cp /nailgun/nailgun-server/target/nailgun-server-1.0.1.jar /output/build
cp /nailgun/nailgun-client/target/ng /output/build