/* global chrome: false */

chrome.app.runtime.onLaunched.addListener(function () {
  'use strict';

  var winOptions = {
    bounds: {
      width: 1280,
      height: 720
    },
    frame: {
      type: 'chrome'
    }
  };

  chrome.runtime.getPlatformInfo(function (info) {
    // correct for window-frame color on win8, so fullscreen does not show white border.
    if (info.os === 'win') {
      winOptions.frame.color = '#000';
    }

    chrome.app.window.create('index.html', winOptions);
  });
});
