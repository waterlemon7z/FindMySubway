'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "c965dcd32792ad11c9b00cbcf7467e50",
"index.html": "4f8b5f6c3fd2ec234e1d9221d84d64c7",
"/": "4f8b5f6c3fd2ec234e1d9221d84d64c7",
"main.dart.js": "422c9f4ae4405bad5006c39bf3a813ca",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "f69077c63d58dc632547d324056f947b",
".git/ORIG_HEAD": "b9bb00a9fc0a9f8e59ca86cc18cb8425",
".git/objects/95/961bf9010a17801d9c9f3813c5274348d6c0b5": "5431151d61c9a574ac4336f003d7b01c",
".git/objects/0c/8c5e785cf10f2f34177a641cb719f3332a3561": "c3bbec57fc0c5f19ae972f105004d61c",
".git/objects/50/c3cd918c5b5c33716e950bed83b9b85b71f2eb": "c5740a1c4982924a7d0edd4a9b81103f",
".git/objects/03/eaddffb9c0e55fb7b5f9b378d9134d8d75dd37": "87850ce0a3dd72f458581004b58ac0d6",
".git/objects/56/75310b43acfca8ea88a1d9e8f68126f3fd7e0e": "c4caa85355299036768f046e728701b7",
".git/objects/94/75b507834781551570d4a3ac627c45a92c142b": "23579c8d61273be22e0d6baaed91d195",
".git/objects/34/244a9fc14e4c785a96076973fd14f05c5f7bc5": "f277980fe1458b01512a1df06150ec31",
".git/objects/5a/fb87e597707309eae71ca89643ae04cad0e2c3": "2d9a15e43da761be1a523d38c971a060",
".git/objects/9c/a32deea6d4f849520deedb0af591b97c86aca2": "c9a01c627685f6256888fba894b26429",
".git/objects/d6/79993a0dedf109473beba8699b6e71f19817a3": "a0dc17864e842a0e4a43a0b9342e9d64",
".git/objects/f4/3c56d2adbff6e03180d2851669ffdcaaeaaa83": "e296bbe246988a171d25f96a61a17a2f",
".git/objects/fd/7ca843b36c49fdd0d4f0f78389f8621069bf58": "e3ebaef3d3db35b3aedef66f00e2bac7",
".git/objects/ca/e2924b3258527da33810ca26c1bd6393967ba9": "43a38ff6a00b06f18f59862438eded3f",
".git/objects/fe/7ee8693d46195531c6bceaf1ddef589356f987": "e1c9553dade3d81802ffe6ba763c71bc",
".git/objects/4e/ece34f1af71de7177a9d4321af1d768eb1b901": "cc0ce8af1100d47ab75d5446c5795d00",
".git/objects/27/94404d1f169c43aae8dd15fa76bc8fc65f8b8d": "0d225b307feb8ba2a5507de641d8d680",
".git/objects/4b/825dc642cb6eb9a060e54bf8d69288fbee4904": "75589287973d2772c2fc69d664e10822",
".git/objects/10/6a18985551600423bea468b81ddd60b8ccaf5b": "00752f571b54ec11d8c6b12bd5b50b43",
".git/objects/86/b3f42452de21aa94854bdebbf903ada2d6ec3a": "521cb3c518334c3f3f06acb1f380e1f9",
".git/objects/72/d2410ae4028957e39b9484a462fac633fdee34": "3bae35c3cc430f56165b9dff4aafab43",
".git/objects/2a/d8213a66c58dbb542a462fe0703917196930d7": "bb307e02f45e0b289d59fa142e586b10",
".git/objects/38/938115a55bdaa8db7299472bf959773e3ad1a1": "16b93ef2d4f39e46e35078423c75ed78",
".git/objects/9a/bcaac9405c325ec3711a8bd4d8afe686c32e33": "14c0552220d0c7b3778afa6cc272ca2d",
".git/objects/31/e0f8d2c45d0ce001738896cc702968e963e117": "143a03157e915a9a67d0ea4e5e4c75f7",
".git/objects/3a/71ee4f8e40866443340c4c8b7ede10d9d16a78": "434839723eb18e81c21b86e7601b53d4",
".git/objects/54/c7c71816d86045a1d2a718cb4aae250c17e9a9": "d630763adea9551502dde3b522105097",
".git/objects/5e/25ecbfcd51a3317abb5becd9ce9473749cc742": "b6493852ddd93d0c588ec7a1b308670b",
".git/objects/55/cb5665665204420009b511c51eccd977b56cdf": "7a391f57efa78088a5fd5ac5fd1cbb1c",
".git/objects/97/df94b4d7810d86c01586b0fac8baf7f5a01a4f": "fddf648a9270df6c6489af6adbf6a1c7",
".git/objects/63/0cb8785f57cd4d260ec093ec49eecaa32579ec": "5b034fe8affd8bac3cd700a2e20ccd5b",
".git/objects/d4/bdf3f8a0e585f3f4d75032975c489bc640c8b8": "85aa66c0505508c9ce043f44cfc6c62d",
".git/objects/a9/5b13a7828f4f4bff517a2603fd4f2a9816cb92": "cf01a315ec96dde2b569366d45d2a586",
".git/objects/a9/89679a17ffaf7b3c1eebc235a7c5bc645a167c": "d3b7a517162a1017fba8dd01795c6ade",
".git/objects/d2/c5494219d569f4b5ea81b9361045c7843bf822": "ae8ec1269f2c915cfd3baa30c4f35e8d",
".git/objects/b7/e95f9cf1c042b2694dff6b6b23e6ddf5beee4d": "803633744cd0f0d8d9ea070652c732af",
".git/objects/ef/a2a4b703a8deb254afcd7de268947648f17637": "4573a6dddfc9b4718675284333d73e14",
".git/objects/e1/feb03ff9a3a0e409d77625dec29e6e41ec0bd2": "50082520663a541b8698c9e20d946937",
".git/objects/e1/6ccb45089f381aedd61c8bbb92a2e4ef905b66": "257b0add3ec836b6d1f1c12cb8c120c3",
".git/objects/e9/5b5490194908f9f152172249ed8cf76ed9760c": "251747a168bab7b4bd31cb2d5c345388",
".git/objects/f1/88c83202f41f016aac7b48ce391e7dcc606f05": "01c5b2aa93e9631052ad3010811f59fc",
".git/objects/e7/5e920f175da53dd6f04d858636baa25dc702f4": "0fd694d0b7477cee41611e70d0cd6732",
".git/objects/83/7e291d4a00edbca45a505e979f5b81e687942f": "284bcbe689b19f5416a8b551e1b6e5a6",
".git/objects/1b/7cb97dd69964814ecb2e2988c02bf4392f981e": "7cceb0edacc798e94084304f130991e0",
".git/objects/84/099d05f9b85453c17937cb1686e9b49fc2d07b": "35d6694eed5931c60753c7255a6967ce",
".git/objects/84/eedc380bca1d214adfb628f17a02d11e86112b": "b8fa661a38275c5316336b1f4cc7a471",
".git/objects/1d/14daa5b2ffac6cf164a25d24c07b12975dee0c": "cc73ae25cf788895706d98571957db63",
".git/objects/82/d4a6afbc47f84485bdb686e3d30793da0617c3": "cf594b87aadf3158ae48aac358d1dd9d",
".git/objects/8b/38d1fe28b9d45981b72e6ea4c5370ce49a2151": "7eddd6c597ac2197e121f1e70dd9893c",
".git/objects/13/e58a142aa288db0f1504bb88432e7b89241254": "ff43efa179ea58120846b31b77879c6e",
".git/objects/8e/f12b0fffe8ecd7957fb7e175ab316936207106": "7eceff262ad78b90260c6fd6467fced2",
".git/logs/refs/remotes/website/main": "feb0e218aab8379a9fc77e137ce6d9ee",
".git/refs/remotes/website/main": "37c0b9901f9fde2be77824895e51e2a2",
".git/packed-refs": "a891e6bb26eb0d480aef486a7e8ea166",
".git/FETCH_HEAD": "b1778eb58aafebacd43c3ae67d79a3cd",
"assets/AssetManifest.json": "7b672bd8e50a35423bc3456addd2cc2f",
"assets/NOTICES": "90af76062dae861fdef45c8769271715",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/fluttertoast/assets/toastify.js": "e7006a0a033d834ef9414d48db3be6fc",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/subwayData.json": "3f7a64dcd46548a3f46ac2b3ac1a46e6",
"assets/assets/subway.png": "17d09b7e2118ed4172e5e82eb66d64e7",
"assets/assets/subway_white.png": "66906a1b6a53aa21d3503b3cbe7d8a58",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99"
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
