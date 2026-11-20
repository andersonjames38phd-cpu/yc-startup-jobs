#!/usr/bin/env bash
# YC Jobs Scraper - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~yc-startup-jobs"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. Remote engineering jobs above $150K (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "roles": [
      "software-engineer"
    ],
    "locations": [
      "remote"
    ],
    "minSalaryK": 150
  }'

# 2. Sales and marketing jobs with company details (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "roles": [
      "sales-manager",
      "marketing"
    ],
    "includeCompanyDetails": true
  }'

# 3. Every open job at specific companies (wait and get the dataset items in one call)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "companies": [
      "numeral",
      "https://www.ycombinator.com/companies/recall-ai"
    ]
  }'
