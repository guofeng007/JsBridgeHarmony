import webView from '@ohos.web.webview';
import promptAction from '@ohos.promptAction';
import { JsBridge } from '../common/JsBridge';

@Component
export struct BridgeWebView {
  private controller: webView.WebviewController = new webView.WebviewController();
  private webUrl: string | Resource = 'https://www.baidu.com/';
  // 声明需要注册的对象
  bridge = {
    call: (param: string) => {
      if (param) {
        const bridgeParam = JSON.parse(param);
        if (bridgeParam.method) {
          JsBridge.getInstance().call(bridgeParam.method, param, this.controller);
        }
      }

    }
  }

  build() {
    //加载网络url
    // Web({ src: this.webUrl, controller: this.controller })
    //加载本地html
    Web({ src: this.webUrl, controller: this.controller })
      //允许访问本地文件
      .fileAccess(true)
        //设置是否允许执行JavaScript脚本
      .javaScriptAccess(true)
        //注入JavaScript对象到window对象中，并在window对象中调用该对象的方法
      .javaScriptProxy({
        object: this.bridge,
        name: "jsBridge",
        methodList: ["call"],
        controller: this.controller
      })
      .onPageEnd(event => {
        //异步执行JavaScript脚本 调用H5方法
        this.controller.runJavaScript("callH5Method()")
          .then(result => {
            console.log(`H5返回值=${result}`)
          })
          .catch(error => {
            console.error("error: " + error);
          })
      })
      .onAlert((event?: {
        url: string;
        message: string;
        result: JsResult;
      }) => {
        promptAction.showToast({ message: event?.message })
        event.result.handleConfirm()
        return true;
      })
  }
}