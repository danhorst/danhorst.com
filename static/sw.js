/*
This is a modified version of the Service Worker from www.nd.edu created by Erik Runyon
 It, in turn, is based on Jeremy Keith’s service worker (https://adactio.com/serviceworker.js), with a few additional edits borrowed from Filament Group’s. (https://www.filamentgroup.com/sw.js)

Thanks to Jeremy, Filament Group, and Eric for this, and everything else they do.

https://adactio.com/about/
https://www.filamentgroup.com/
https://erikrunyon.com/
*/

(function(){
  'use strict';

  const version = 'v2018-10-27T20:12:00::';
  const staticCacheName = version + 'static';
  const pagesCacheName = version + 'pages';
  const imagesCacheName = version + 'images';
  const offlinePages = [
    '/about/',
    '/lists/',
    '/writing/',
    '/'
  ];

  const staticAssets = [
    '/css/main.css',
    '/css/et-book/et-book-bold-line-figures.woff2',
    '/css/et-book/et-book-display-italic-old-style-figures.woff2',
    '/css/et-book/et-book-roman-line-figures.woff2',
    '/css/et-book/et-book-roman-old-style-figures.woff2',
    '/css/et-book/et-book-semi-bold-old-style-figures.woff2',
    '/js/turbolinks.js'
  ];

  function stashInCache(cacheName, request, response){
    caches.open(cacheName)
      .then( cache => cache.put(request, response) );
  }

  function updateStaticCache(){
    //try to fetch static top level pages - can be done after install.
    caches.open(pagesCacheName)
      .then( cache => {
        // These items must be cached for the Service Worker to complete installation
        return cache.addAll(offlinePages.map(url => new Request(url, {credentials: 'include'})));
      });

    return caches.open(staticCacheName)
      .then( cache => {
        // These items must be cached for the Service Worker to complete installation
        return cache.addAll(staticAssets.map(url => new Request(url, {credentials: 'include'})));
      });
  }

  // Limit the number of items in a specified cache.
  function trimCache(cacheName, maxItems){
    caches.open(cacheName)
      .then( cache => {
        cache.keys()
          .then(keys => {
            if(keys.length > maxItems){
              cache.delete(keys[0])
                   .then(trimCache(cacheName, maxItems));
            }
          });
      });
  }

  // Remove caches whose name is no longer valid
  function clearOldCaches(){
    return caches.keys()
      .then( keys => {
        return Promise.all(keys
          .filter(key => key.indexOf(version) !== 0)
          .map(key => caches.delete(key))
        );
      });
  }

  self.addEventListener('install', event => {
    event.waitUntil(updateStaticCache()
      .then( () => self.skipWaiting() )
    );
  });

  self.addEventListener('activate', event => {
    event.waitUntil(clearOldCaches()
      .then( () => self.clients.claim() )
    );
  });

  self.addEventListener('message', event => {
    if(event.data.command === 'trimCaches'){
      trimCache(pagesCacheName, 35);
      trimCache(imagesCacheName, 20);
    }
  });

  // Pass offline pages cache for display on the Offline page
  self.addEventListener('message', event => {
    if(event.data.command == 'getAvailableOffline'){
      let pages = [];
      caches.open(pagesCacheName).then(function(cache){
        cache.keys().then(function(keys){
          keys.forEach(function(request, index, array){
            getResponseMeta(cache, request).then(meta => {
              if(meta) pages.push(meta);
              if(index == array.length - 1) event.ports[0].postMessage({'offline_pages': pages});
            });
          });
        });
      }).catch(e => { console.log(e) } );
    }
  });

  // Gets Title and Description from the response text
  function getResponseMeta(cache, request){
    return cache.match(request).then(response => {
      return response.text().then(function(html){
        let title = html.match(/<title>([^<]+)<\/title>/)[1];
        let description = html.match(/<meta property="og:description" name="description" content="([^"]+)">/)[1];
        let url = new URL(request.url).pathname;

        return {
          title: title,
          description: description,
          url: url
        };
      });
    });
  }
  
  self.addEventListener('fetch', event => {
    let request = event.request;
    let url = new URL(request.url);

    // Ignore requests to some directories
    if( request.url.indexOf('google-analytics') !== -1 ){
      return;
    }

    // Ignore non-GET requests
    if(request.method !== 'GET'){
      return;
    }

    // For HTML requests, try the network first, fall back to the cache, finally the offline page
    if(request.headers.get('Accept').indexOf('text/html') !== -1){

      event.respondWith(
        fetch(request)
          .then( response => {
            // NETWORK
            // Stash a copy of this page in the pages cache
            let copy = response.clone();
            if(offlinePages.includes(url.pathname) || offlinePages.includes(url.pathname + '/')){
              stashInCache(staticCacheName, request, copy);
            } else {
              stashInCache(pagesCacheName, request, copy);
            }
            return response;
          })
          .catch( () => {
            // CACHE or FALLBACK
            return caches.match(request)
                .then( response => response || caches.match('/offline/') );
          })
      );
      return;
    }

    // Deal with cache busting CSS/JS
    let regex = /^(.+)\.(\d+)\.(js|css)$/;
    if(event.request.url.match(regex)){
      let match = event.request.url.match(regex),
          cachestring = '.' + match[2],
          re = new RegExp(cachestring, "g"),
          newurl = request.url.replace(re, '')
      ;

      event.respondWith(
        fetch(request)
          .then( response => {
            return response;
          })
          .catch( () => {
            return caches.match(newurl).then( caches.match(newurl) );
          })
      );
      return;
    }

    // For non-HTML requests, look in the cache first, fall back to the network
    event.respondWith(
      caches.match(request)
        .then(response => {
          // CACHE
          return response || fetch(request)
            .then( response => {
              // NETWORK
              // If the request is for an image, stash a copy of this image in the images cache
              if(request.headers.get('Accept').indexOf('image') !== -1){
                let copy = response.clone();
                stashInCache(imagesCacheName, request, copy);
              }
              return response;
            })
            .catch( () => {
              // OFFLINE
              // If the request is for an image, show an offline placeholder
              if(request.headers.get('Accept').indexOf('image') !== -1){
                return new Response('<svg role="img" aria-labelledby="offline-title" viewBox="0 0 400 300" xmlns="http://www.w3.org/2000/svg"><title id="offline-title">Offline</title><rect fill="#000000" x="0" y="0" width="100%" height="100%" opacity="0.2" fill-rule="evenodd"/><text fill="#ffffff" opacity="0.1" font-family="GPC,Helvetica Neue,Arial,Helvetica,sans-serif" font-size="72" font-weight="bold"><tspan x="93" y="172">offline</tspan></text></svg>', {headers: {'Content-Type': 'image/svg+xml'}});
              }
            });
        })
    );
  });

})();
