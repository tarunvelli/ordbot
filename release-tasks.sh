#!/bin/bash

echo "Running Release Tasks"

bundle exec rake db:migrate
bundle exec rake cache:clear

echo "Done running release-tasks.sh"
