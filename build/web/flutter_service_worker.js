'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.bin": "0dec632b306beafa5a50614471388ba5",
"assets/AssetManifest.json": "5db878c7b2d6a5daf22480aff5d71ba2",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "0e0ae6898b326cde324d300caed51aa6",
"assets/lib/images/charsAnimelee/bowser.png": "df4c0a673b41360f98ba3bc8d475ddbd",
"assets/lib/images/charsAnimelee/donkey_kong.png": "dbffe59893b57460dbc7ea8bf845fa1c",
"assets/lib/images/charsAnimelee/dr_mario.png": "c261b8fc8c7061d1052ee3c0638c4ced",
"assets/lib/images/charsAnimelee/falco.png": "c0500a0949a65311a53df8c0e41cb16c",
"assets/lib/images/charsAnimelee/falcon.png": "5d7100494c286ee4294dbe65258a2902",
"assets/lib/images/charsAnimelee/fox.png": "e0a30de0b3956cb7a158943615b3e2fa",
"assets/lib/images/charsAnimelee/game_and_watch.png": "47e6193e97280a081c68f437f3dca378",
"assets/lib/images/charsAnimelee/ganon.png": "557f51658d17e5d26c689675d5d4a35e",
"assets/lib/images/charsAnimelee/ice_climbers.png": "f64d8c56796d4e9ca851aefb0e845ea3",
"assets/lib/images/charsAnimelee/jigglypuff.png": "6cf5e5ecb2e3cb555a29521e384c69f2",
"assets/lib/images/charsAnimelee/kirby.png": "63bfef3d9131f07e64d07b056411310b",
"assets/lib/images/charsAnimelee/link.png": "076b7caa31dc74c9c8472ebe370cbf54",
"assets/lib/images/charsAnimelee/luigi.png": "eafe77b1e123b42d2d2f9a8162fc9131",
"assets/lib/images/charsAnimelee/mario.png": "f1a6e5e48e09c0c38c833265a2989e83",
"assets/lib/images/charsAnimelee/marth.png": "930ffc3fcecb82f9e1ad6bc8443b3a59",
"assets/lib/images/charsAnimelee/mewtwo.png": "69dca9bf3a9a2605e78d9c906816dae4",
"assets/lib/images/charsAnimelee/ness.png": "c57bb208f11dddd6dc5a5c9274ac2fcf",
"assets/lib/images/charsAnimelee/peach.png": "00082ed1a1fe89f889e5f2f59c83b2fc",
"assets/lib/images/charsAnimelee/pichu.png": "c3750b7e168d9376a49093e6d59dd0c8",
"assets/lib/images/charsAnimelee/pikachu.png": "57cc1e3176a17c6df2b1eaab28341e12",
"assets/lib/images/charsAnimelee/roy.png": "9d4fad595a70edad258fe1d8633cf8c9",
"assets/lib/images/charsAnimelee/samus.png": "ee78118e55efd87716ff2ac0369bf7e9",
"assets/lib/images/charsAnimelee/sheik.png": "33c27afdf4d09af23caa39681c5d0fef",
"assets/lib/images/charsAnimelee/smash.png": "03f9f0985a698ef5fc683763a75168d8",
"assets/lib/images/charsAnimelee/yoshi.png": "20740cebeb1c71936147157f493c819c",
"assets/lib/images/charsAnimelee/young_link.png": "4fa111d9722046a5e239fc648828e6e4",
"assets/lib/images/charsAnimelee/zelda.png": "608214de839b5d15716d48f48f21aa1c",
"assets/lib/images/facebook_logo.png": "e1c8ca9c5506ee4e74cd4c1207c77362",
"assets/lib/images/google_logo.png": "3a9d51aedbe7af80b573509dd0e30256",
"assets/lib/images/meleenotes.png": "b528e0a99a9a73eedcefeb7e576608f6",
"assets/lib/images/meleenotes_logo.png": "37725dd2efaae48da1f548875ee4358b",
"assets/NOTICES": "260c461eccc40ec59b76c5d12a8e9be6",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/shaders/ink_sparkle.frag": "92666cc97576adbea2e2d3061a953137",
"canvaskit/canvaskit.js": "678d9f53b0e5c5f22543631f43279fb9",
"canvaskit/canvaskit.wasm": "6972cd6e8f48c5f3c027416c7b2443a6",
"canvaskit/profiling/canvaskit.js": "5a0f05139f1d43c603dcfc67d15b1ec9",
"canvaskit/profiling/canvaskit.wasm": "09aacbc0d8b20c7ee684e310703e2d86",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "1cfe996e845b3a8a33f57607e8b09ee4",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "b0b9e7ce1d782e86717cdd9e75a11603",
"/": "b0b9e7ce1d782e86717cdd9e75a11603",
"main.dart.js": "d66e0def844cd4c3392aa9dd6fe162f6",
"manifest.json": "4e85ddd8dc5b29785d8ef5d67a42a06e",
"version.json": "d490fbb59879c6a44ab213b4713433ce"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
