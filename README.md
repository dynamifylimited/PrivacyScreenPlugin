# PrivacyScreenPlugin

Both iOS (as of iOS 7) and Android have app switchers that display a screenshot of your app.

This is a lovely feature for most apps, but if your app displays sensitive information this is a possible privacy risk.

This plugin flags your app so that it doesn't show your users' sensitive data in the task switcher. It sets the
[FLAG_SECURE](http://developer.android.com/reference/android/view/WindowManager.LayoutParams.html#FLAG_SECURE)
flag in Android (which also prevents manual screenshots from being taken) and hides the window in iOS.

On iOS this plugin will try to show a black screen in the app switcher.

Test this plugin on a real device because the iOS simulator (7.1 at least) does a poor job hiding your app.

## Installation

1. To add this plugin type: `cordova plugin add https://github.com/dynamifylimited/PrivacyScreenPlugin.git`
2. To remove this plugin type: `cordova plugin remove cordova-plugin-privacyscreen`

## Usage in javascript

```js
document.addEventListener("deviceready", onDeviceReady, false);
// Enable
function onDeviceReady() {
    cordova.plugins.PrivacyScreenPlugin.enable(successCallback, errorCallback);
}
// Disable
function onDeviceReady() {
    cordova.plugins.PrivacyScreenPlugin.disable(successCallback, errorCallback);
}

function successCallback(result) {
  console.log(result);
}

function errorCallback(error) {
  console.log(error);
}
```

## License

The MIT License

Copyright (c) 2016 Tommy-Carlos Williams (http://github.com/devgeeks)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

