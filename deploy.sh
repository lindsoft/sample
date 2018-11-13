#!/bin/bash
docker build -t lindsoft/sample-node .
docker push lindsoft/sample-node

ssh deploy@159.203.127.59 << EOF
docker pull lindsoft/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi lindsoft/sample-node:current || true
docker tag lindsoft/sample-node:latest lindsoft/sample-node:current
docker run -d --net app --restart always --name web -p 3000:3000 lindsoft/sample-node:current
EOF
