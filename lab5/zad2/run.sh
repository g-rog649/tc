#!/bin/bash
docker build -t lab5-zad2 .
export $(cat app/.env)
docker run -p "$PORT:$PORT" lab5-zad2

