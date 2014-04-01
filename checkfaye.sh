#!/bin/bash
while true
do
  if lsof -t -i:8080 >/dev/null; then
	  sleep 15
  else
    rackup private_pub.ru -s thin -E production -p 8080 &
	sleep 15
  fi
done