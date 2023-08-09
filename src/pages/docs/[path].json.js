export function getStaticPaths() {
  return [
    {params: {path: 'index'}},
  ];
}
export async function get({params, request}) {
  return {
    body: JSON.stringify({
        "guides": [
          {
            "id": "quick-start-guide",
            "name": "Quick Start Guide",
            "url": "https://www.seriesphotos.app/docs/quick-start-guide.html"
          },
          {
            "id": "series2-updates-guide",
            "name": "Series 2.0 Updates Guide",
            "url": "https://www.seriesphotos.app/docs/series2-updates-guide.html"
          },
          {
            "id": "threads",
            "name": "Using Series with Threads",
            "url": "https://www.seriesphotos.app/docs/threads.html"
          }
        ],
        "manuals": []
    }),
  };
}