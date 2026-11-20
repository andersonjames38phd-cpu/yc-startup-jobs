// YC Jobs Scraper - Node.js example
// npm install apify-client
// APIFY_TOKEN=your_token node node.mjs
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

// Sales and marketing jobs with company details
const run = await client.actor('Turboextract/yc-startup-jobs').call({
    "roles": [
        "sales-manager",
        "marketing"
    ],
    "includeCompanyDetails": true
});

const { items } = await client.dataset(run.defaultDatasetId).listItems();
for (const item of items) {
    console.log(item.company, item.batch, item.title, item.salaryRange);
}
