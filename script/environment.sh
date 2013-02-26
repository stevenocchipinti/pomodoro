#!/bin/sh
#
# Source this file to setup the required environment variables
#
# This app requires credentials for:
#   - Pusher to provide WebSockets connectivity
#   - Google to store statistics in a Google spreadsheet (TODO: coming soon..)
#

export RACK_ENV="development"
export PUSHER_APP_ID="37160"
export PUSHER_KEY="0c1a264aa39b08c48fba"
export PUSHER_SECRET="65a91effa58f0c5cf515"
# GOOGLE_USERNAME=""
# GOOGLE_PASSWORD=""
