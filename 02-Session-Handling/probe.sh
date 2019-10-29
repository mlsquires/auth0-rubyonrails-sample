#!/bin/bash

set -x -v

BASE_URL=http://localhost:3002

curl --silent $BASE_URL/ > ,root
curl --silent $BASE_URL/logout > ,logout
curl --silent $BASE_URL/dashboard/show > ,dashboard_show
curl --silent $BASE_URL/auth/auth0/callback > ,auth_auth0_callback
curl --silent $BASE_URL/auth/failure > ,auth_failure

set +x +v
