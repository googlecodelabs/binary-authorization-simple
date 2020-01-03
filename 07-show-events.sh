#!/bin/bash

kubectl get event --template '{{range.items}}{{"\033[0;36m"}}{{.reason}}:{{"\033[0m"}}{{.message}}{{"\n"}}{{end}}'
