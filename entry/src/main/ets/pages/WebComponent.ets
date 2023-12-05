import webView from '@ohos.web.webview';

@Entry
@Component
struct WebComponent {
  controller: webView.WebviewController = new webView.WebviewController();
  webUrl: string = 'https://www.baidu.com/'
  jsBridge = {
    callNaMethod() {
      console.log("H5调用Native方法")

    }
  }

  aboutToAppear(){
    webView.WebviewController.setWebDebuggingAccess(true)
  }

  build() {
    Stack() {
      //加载网络url
      // Web({ src: this.webUrl, controller: this.controller })
      //加载本地html
      Web({ src: $rawfile("demo.html"), controller: this.controller })
        //允许访问本地文件
        .fileAccess(true)
          //设置是否允许执行JavaScript脚本
        .javaScriptAccess(true)
          //注入JavaScript对象到window对象中，并在window对象中调用该对象的方法
        .javaScriptProxy({
          object: this.jsBridge,
          name: "jsBridge",
          methodList: ["callNaMethod"],
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
    }
  }
}