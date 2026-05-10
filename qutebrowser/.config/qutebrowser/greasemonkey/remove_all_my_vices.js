// ==UserScript==
// @name         Remove All My Vices
// @namespace    local.selfcontrol
// @version      1.0
// @description  Redirect distracting websites
// @match        *://*.facebook.com/*
// @match        *://facebook.com/*
// @run-at       document-start
// ==/UserScript==

(function () {
  "use strict";

  const REDIRECT_URL = "qute://start/";

  window.location.replace(REDIRECT_URL);
})();
