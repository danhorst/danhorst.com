const version = "v1::" // Change value to force cache regeneration
const staticCacheName = `${version}static-resources`;

const offlineFiles = [
  '/style/et-book/et-book-bold-line-figures.woff',
  '/style/et-book/et-book-bold-line-figures.woff2',
  '/style/et-book/et-book-display-italic-old-style-figures.woff',
  '/style/et-book/et-book-display-italic-old-style-figures.woff2',
  '/style/et-book/et-book-roman-line-figures.woff',
  '/style/et-book/et-book-roman-line-figures.woff2',
  '/style/et-book/et-book-roman-old-style-figures.woff',
  '/style/et-book/et-book-roman-old-style-figures.woff2',
  '/style/et-book/et-book-semi-bold-old-style-figures.woff',
  '/style/et-book/et-book-semi-bold-old-style-figures.woff2'
]

self.addEventListener('install', (event) => {
  console.log('Install')
  event.waitUntil(
    caches
    .open(staticCacheName)
    .then((cache) => {
      return cache.addAll(offlineFiles);
    })
    .then(() => {
      console.log('WORKER:: install completed');
    })
  )
});
