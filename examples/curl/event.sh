#!/usr/bin/env bash
# Ticketmaster Event API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./event.sh
set -euo pipefail

curl -sS --fail-with-body -G "https://api.piloterr.com/v2/ticketmaster/event" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=https://www.ticketmaster.com/suns-vs-jazz-kids-day-phoenix-arizona-01-24-2027/event/19006507A7257EEA
