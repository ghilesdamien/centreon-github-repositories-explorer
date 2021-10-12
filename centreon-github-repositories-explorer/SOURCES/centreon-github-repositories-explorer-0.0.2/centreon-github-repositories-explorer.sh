#!/bin/bash
#Getting Centreon GitHub repositories
curl --silent "https://api.github.com/users/centreon/repos" | jq -r '.[] | .name+" : "+.html_url'
