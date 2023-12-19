import router from '@ohos.router';
import {JsBridge,JsCallback} from '../common/JsBridge';
import webview from '@ohos.web.webview';
import {BridgeWebView} from '../view/BridgeWebView';
@Entry
@Component
struct Index {
  @State message: string = 'Debug webview';
  private controller: webview.WebviewController = new webview.WebviewController();


  aboutToAppear(){
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
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
        Button("call webview from native")
          .margin(10)
          .onClick(() => {

            this.controller.runJavaScript('callH5Method("call from native")');
          })

        Button("register yeppy method")
          .margin(10)
          .onClick(() => {
            JsBridge.getInstance().register("yeppy",(param:string,callback:JsCallback )=>{
              callback("yeppy");
            })

          })
        BridgeWebView({
          webUrl:$rawfile('demo.html'),
          controller: this.controller
        })
          .height("100%")

      }
      .width('100%')
    }
    .height('100%')
  }
}