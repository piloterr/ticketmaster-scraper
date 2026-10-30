// Ticketmaster Event API – Node.js example (Node 18+, native fetch, ES module)
// Usage: PILOTERR_API_KEY=your-key node event.mjs

const params = new URLSearchParams({
  "query": "https://www.ticketmaster.com/suns-vs-jazz-kids-day-phoenix-arizona-01-24-2027/event/19006507A7257EEA",
});

const response = await fetch(`https://api.piloterr.com/v2/ticketmaster/event?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY },
  signal: AbortSignal.timeout(60_000),
});

if (!response.ok) {
  console.error(`Piloterr error ${response.status}: ${await response.text()}`);
  process.exit(1);
}

console.log(JSON.stringify(await response.json(), null, 2));
