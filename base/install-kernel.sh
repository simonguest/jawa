touch repo.list
apk add --repositories-file=repo.list --allow-untrusted --no-network --no-cache /build/linux-virt-5.15.4-r0.apk
rm repo.list