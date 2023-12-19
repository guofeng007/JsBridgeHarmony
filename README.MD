# JsBridge

-----

inspired and modified from [this](https://github.com/jacin1/JsBridge) and [lzyzsd/jsbridge](https://github.com/lzyzsd/JsBridge) and wechat jsBridge file, with some bugs fix and feature enhancement.

This project make a bridge between ArkTS and JavaScript.

It provides safe and convenient way to call ArkTS code from js and call js code from ArkTS.

## Demo

## Usage

## SourceCode


## Use it in ArkTS

add com.github.lzyzsd.jsbridge.BridgeWebView to your layout, it is inherited from WebView.

### Register a ArkTS handler function so that js can call

```typescript
import {JsBridge,JsCallback} from '../common/JsBridge';

JsBridge.getInstance().register("hello",(param:string,callback:JsCallback )=>{

  let result = '';
  if(param) {
    const bridgeParam = JSON.parse(param);
    if (bridgeParam.method) {
      result = bridgeParam.method;
    }
  }
  result +=' world';
  callback(result);

})

```

js can call this ArkTS handler method "submitFromWeb" through:

```javascript

function callNativeMethod() {
    var param = {method:'hello',value:'world',callback:'callH5Method'};
    window.jsBridge.call(JSON.stringify(param));
}

```


## License

This project is licensed under the terms of the MIT license.
