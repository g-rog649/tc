#!/bin/bash
docker rm -f db
docker rm -f frontend
docker rm -f backend
docker network rm frontend_network
docker network rm backend_network
