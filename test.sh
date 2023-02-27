#!/bin/bash

set -e

source ./setenv.sh

# Ensure the app's dependencies are installed
# mix deps.get

# Potentially Set up the database
# mix ecto.drop
# mix ecto.create
# mix ecto.load --skip-if-loaded
# mix ecto.migrate

# echo "Launching Phoenix web server..."
# Start the phoenix web server
# iex -S mix phx.server

mix test ./test/blog_test/blog_test.exs
