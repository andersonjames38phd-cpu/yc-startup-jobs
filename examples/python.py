"""YC Jobs Scraper - Python example.

pip install apify-client
export APIFY_TOKEN=your_token
"""
import os

from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

# Remote engineering jobs above $150K
run = client.actor("Turboextract/yc-startup-jobs").call(run_input={
    "roles": [
        "software-engineer"
    ],
    "locations": [
        "remote"
    ],
    "minSalaryK": 150
})

# Stream every item
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item.get("company"), item.get("batch"), item.get("title"), item.get("salaryRange"))

# Or fetch one page of items
page = client.dataset(run["defaultDatasetId"]).list_items(limit=100)
print(f"{page.total} items in dataset")
