

# JsBridge 鸿蒙版本

-----
https://github.com/guofeng007/JsBridgeHarmony
## 背景
在安卓原生app上，很多经常变更的需求或者营销活动，都是通过h5网页来实现的，而且有些功能依赖安卓原生能力，比如相机、通讯录，这个时候h5是没办法的。
JsBridge通过js和原生通讯，来解决这个问题。

本项目参考 [this](https://github.com/jacin1/JsBridge) and [lzyzsd/jsbridge](https://github.com/lzyzsd/JsBridge) and wechat jsBridge file

这个项目主要是用来在 ArkTS 和网页 JavaScript之间做通信。

![11](https://p.ipic.vip/b2o9vu.jpg)



##  ArkTS 使用


### 添加UI组件 BridgeWebView
```typescript
build()
{
  BridgeWebView({
    webUrl: $rawfile('demo.html'),
    controller: this.controller
  })
    .height("100%")
}
```


### 注册Native能力

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

### h5通过如下方法调用端能力

```javascript

function callNativeMethod() {
    var param = {method:'hello',value:'world',callback:'callH5Method'};
    window.jsBridge.call(JSON.stringify(param));
}

```


## License

This project is licensed under the terms of the MIT license.


开源代码地址：
https://github.com/guofeng007/JsBridgeHarmony
