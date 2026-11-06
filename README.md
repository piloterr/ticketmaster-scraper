<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="Ticketmaster Scraper API by Piloterr – scrape Ticketmaster data as JSON" width="100%"></a>
</p>

# Ticketmaster Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr Ticketmaster Scraper API** lets you extract public data from Ticketmaster as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **Ticketmaster Event API** — Fetch one Ticketmaster event from a slugged event URL.
- **Ticketmaster Search API** — Search Ticketmaster events by keyword.

Use it for price monitoring, assortment tracking, competitor analysis, product research or catalog enrichment.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [Ticketmaster Event API](#ticketmaster-event-api) | `/v2/ticketmaster/event` | 1 | Fetch one Ticketmaster event from a slugged event URL. The slug is searched and the matching event id is returned with the venue address. |
| [Ticketmaster Search API](#ticketmaster-search-api) | `/v2/ticketmaster/search` | 1 | Search Ticketmaster events by keyword. Returns event cards, including Ticketweb partner rows, and pagination. |

## Table of contents

- [How it works](#how-it-works)
- [Ticketmaster Event API](#ticketmaster-event-api)
- [Ticketmaster Search API](#ticketmaster-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Official SDKs](#official-sdks)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## Ticketmaster Event API

Fetch one Ticketmaster event from a slugged event URL. The slug is searched and the matching event id is returned with the venue address.

`GET | POST https://api.piloterr.com/v2/ticketmaster/event` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Required. Slugged event URL, example https://www.ticketmaster.com/suns-vs-jazz-kids-day-phoenix-arizona-01-24-2027/event/19006507A7257EEA. A short /event/{discoveryId} link has no slug and cannot be resolved. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/ticketmaster/event",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://www.ticketmaster.com/suns-vs-jazz-kids-day-phoenix-arizona-01-24-2027/event/19006507A7257EEA",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type TicketmasterEvent = {
  id?: string;
  tba?: boolean;
  url?: string;
  image?: string;
  title?: string;
  artists?: string[];
  latitude?: number;
  presales?: unknown[];
  sold_out?: boolean;
  timezone?: string;
  cancelled?: boolean;
  longitude?: number;
  postponed?: boolean;
  venue_url?: string;
  start_date?: string;
  venue_city?: string;
  venue_name?: string;
  onsale_date?: string;
  postal_code?: string;
  rescheduled?: boolean;
  seatmap_url?: string;
  venue_state?: string;
  discovery_id?: string;
  venue_address?: string;
  venue_country?: string;
  [key: string]: unknown;
};

const params = new URLSearchParams({
  "query": "https://www.ticketmaster.com/suns-vs-jazz-kids-day-phoenix-arizona-01-24-2027/event/19006507A7257EEA",
});

const response = await fetch(`https://api.piloterr.com/v2/ticketmaster/event?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as TicketmasterEvent;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/ticketmaster/event
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://www.ticketmaster.com/suns-vs-jazz-kids-day-phoenix-arizona-01-24-2027/event/19006507A7257EEA"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "id": "19006507A7257EEA",
  "tba": false,
  "url": "https://www.ticketmaster.com/suns-vs-jazz-kids-day-phoenix-arizona-01-24-2027/event/19006507A7257EEA",
  "image": "https://s1.ticketm.net/dam/a/c62/0636ff21-e369-4b8c-bee4-214ea0a81c62_1339761_ARTIST_PAGE_3_2.jpg",
  "title": "Suns vs Jazz: Kids Day",
  "artists": [
    "Phoenix Suns",
    "Utah Jazz"
  ],
  "latitude": 33.445899,
  "presales": [],
  "sold_out": false,
  "timezone": "America/Phoenix",
  "cancelled": false,
  "longitude": -112.071313,
  "postponed": false,
  "venue_url": "https://www.ticketmaster.com/mortgage-matchup-center-tickets-phoenix/venue/205079",
  "start_date": "2027-01-24T21:00:00Z",
  "venue_city": "Phoenix",
  "venue_name": "Mortgage Matchup Center",
  "onsale_date": "2026-08-17T15:00:00Z",
  "postal_code": "85004",
  "rescheduled": false,
  "seatmap_url": "https://mapsapi.tmol.io/maps/geometry/3/event/19006507A7257EEA/staticImage?type=png&systemId=HOST",
  "venue_state": "AZ",
  "discovery_id": "1A_Zkf6GkeEa9Dn",
  "venue_address": "201 East Jefferson Street",
  "venue_country": "US"
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `id` | string |  |
| `tba` | boolean |  |
| `url` | string |  |
| `image` | string |  |
| `title` | string |  |
| `artists` | string[] |  |
| `latitude` | number |  |
| `presales` | any[] |  |
| `sold_out` | boolean |  |
| `timezone` | string |  |
| `cancelled` | boolean |  |
| `longitude` | number |  |
| `postponed` | boolean |  |
| `venue_url` | string |  |
| `start_date` | string |  |
| `venue_city` | string |  |
| `venue_name` | string |  |
| `onsale_date` | string |  |
| `postal_code` | string |  |
| `rescheduled` | boolean |  |
| `seatmap_url` | string |  |
| `venue_state` | string |  |
| `discovery_id` | string |  |
| `venue_address` | string |  |
| `venue_country` | string |  |

## Ticketmaster Search API

Search Ticketmaster events by keyword. Returns event cards, including Ticketweb partner rows, and pagination.

`GET | POST https://api.piloterr.com/v2/ticketmaster/search` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Required. Keyword, example jazz, or a ticketmaster.com search URL such as https://www.ticketmaster.com/search?q=jazz. An event URL is rejected. |
| `page` | number | — | Optional. Page number starting at 1. Example: 2. Defaults to 1. On ticketmaster.com the page query is zero-based, so API page 2 is page=1 on the site. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/ticketmaster/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "jazz",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type TicketmasterSearch = {
  results?: {
    id?: string;
    tba?: boolean;
    url?: string;
    image?: string;
    title?: string;
    artists?: string[];
    sold_out?: boolean;
    timezone?: string;
    cancelled?: boolean;
    postponed?: boolean;
    start_date?: string;
    venue_city?: string;
    venue_name?: string;
    onsale_date?: string;
    rescheduled?: boolean;
    venue_state?: string;
    venue_country?: string;
    ticketing_status?: string;
    event_change_status?: string;
    limited_availability?: boolean;
  }[];
  pagination?: {
    next?: string;
    page?: number;
    per_page?: number;
    total_pages?: number;
    total_results?: number;
  };
};

const params = new URLSearchParams({
  "query": "jazz",
});

const response = await fetch(`https://api.piloterr.com/v2/ticketmaster/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as TicketmasterSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/ticketmaster/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "jazz"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "id": "19006507A7257EEA",
      "tba": false,
      "url": "https://www.ticketmaster.com/suns-vs-jazz-kids-day-phoenix-arizona-01-24-2027/event/19006507A7257EEA",
      "image": "https://s1.ticketm.net/dam/a/c62/0636ff21-e369-4b8c-bee4-214ea0a81c62_1339761_ARTIST_PAGE_3_2.jpg",
      "title": "Suns vs Jazz: Kids Day",
      "artists": [
        "Phoenix Suns",
        "Utah Jazz"
      ],
      "sold_out": false,
      "timezone": "America/Phoenix",
      "cancelled": false,
      "postponed": false,
      "start_date": "2027-01-24T21:00:00Z",
      "venue_city": "Phoenix",
      "venue_name": "Mortgage Matchup Center",
      "onsale_date": "2026-08-17T15:00:00Z",
      "rescheduled": false,
      "venue_state": "AZ",
      "venue_country": "US",
      "ticketing_status": "UNKNOWN",
      "event_change_status": "none",
      "limited_availability": false
    }
  ],
  "pagination": {
    "next": "https://www.ticketmaster.com/search?q=jazz&page=1",
    "page": 1,
    "per_page": 20,
    "total_pages": 199,
    "total_results": 3970
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].id` | string |  |
| `results[].tba` | boolean |  |
| `results[].url` | string |  |
| `results[].image` | string |  |
| `results[].title` | string |  |
| `results[].artists` | string[] |  |
| `results[].sold_out` | boolean |  |
| `results[].timezone` | string |  |
| `results[].cancelled` | boolean |  |
| `results[].postponed` | boolean |  |
| `results[].start_date` | string |  |
| `results[].venue_city` | string |  |
| `results[].venue_name` | string |  |
| `results[].onsale_date` | string |  |
| `results[].rescheduled` | boolean |  |
| `results[].venue_state` | string |  |
| `results[].venue_country` | string |  |
| `results[].ticketing_status` | string |  |
| `results[].event_change_status` | string |  |
| `results[].limited_availability` | boolean |  |
| `pagination` | object |  |
| `pagination.next` | string |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Event | Search |
|---|---|---|
| cURL (Bash) | [`event`](examples/curl/event.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`event`](examples/php/event.php) | [`search`](examples/php/search.php) |
| C# | [`event`](examples/csharp/Event.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`event`](examples/go/event.go) | [`search`](examples/go/search.go) |
| Java | [`event`](examples/java/EventExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`event`](examples/ruby/event.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`event`](examples/nodejs/event.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track prices, promotions and availability over time to react to competitors.
- **Assortment & catalog tracking** — Follow new products, delisted items and category changes.
- **Competitor analysis** — Benchmark ranges, brands and positioning across retailers.
- **Product research** — Spot best-sellers and trends from search results.
- **Catalog enrichment** — Pull titles, images and attributes into your PIM or marketplace listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — Ticketmaster plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape Ticketmaster?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/ticketmaster/event` **1**, `/v2/ticketmaster/search` **1**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the Ticketmaster API return?

Each endpoint returns structured JSON: **Ticketmaster Event** — `id`, `tba`, `url`, `image`, `title`, `artists`; **Ticketmaster Search** — `results[]`, `results[].id`, `results[].tba`, `results[].url`, `results[].image`, `results[].title`.

### How do I paginate Ticketmaster results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Official SDKs

Use Piloterr from your own language with a typed client:

| SDK | Package | Install |
| --- | --- | --- |
| Node.js | [`@piloterr/sdk`](https://www.npmjs.com/package/@piloterr/sdk) | `npm install @piloterr/sdk` |
| Python | [`piloterr`](https://pypi.org/project/piloterr/) | `pip install piloterr` |
| Go | [`piloterr-go`](https://pkg.go.dev/github.com/piloterr/piloterr-go) | `go get github.com/piloterr/piloterr-go` |
| .NET | [`Piloterr`](https://www.nuget.org/packages/Piloterr) | `dotnet add package Piloterr` |
| Ruby | [`piloterr`](https://rubygems.org/gems/piloterr) | `gem install piloterr` |
| PHP | [`piloterr/sdk`](https://packagist.org/packages/piloterr/sdk) | `composer require piloterr/sdk` |
| Java | [`piloterr-java`](https://github.com/piloterr/piloterr-java) | build from source, see its README |
| CLI | [`@piloterr/cli`](https://www.npmjs.com/package/@piloterr/cli) | `npm install -g @piloterr/cli` |
| MCP server | [`@piloterr/mcp`](https://www.npmjs.com/package/@piloterr/mcp) | `npx -y @piloterr/mcp` |

## Related scrapers

- [About You Scraper API](https://github.com/piloterr/aboutyou-scraper)
- [Action Scraper API](https://github.com/piloterr/action-scraper)
- [Aldi Scraper API](https://github.com/piloterr/aldi-scraper)
- [Alibaba Scraper API](https://github.com/piloterr/alibaba-scraper)
- [AliExpress Scraper API](https://github.com/piloterr/aliexpress-scraper)
- [Allegro Scraper API](https://github.com/piloterr/allegro-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>Ticketmaster is a trademark of its respective owner. This repository is not affiliated with or endorsed by Ticketmaster. Examples are released under the MIT license.</sub>
