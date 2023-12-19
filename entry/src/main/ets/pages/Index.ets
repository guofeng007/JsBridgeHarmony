import router from '@ohos.router';
import webView from '@ohos.web.webview';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  @State webDebug: boolean = false

  build() {
    Row() {
      Column() {
        Text("web debug  :" + this.webDebug)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .margin(10)
        Button("go to webview")
          .margin(10)
          .onClick(() => {
            router.pushUrl({ url: "pages/WebViewTest" })
          })
        Button("enable webview debug")
          .margin(10)
          .onClick(() => {
            webView.WebviewController.setWebDebuggingAccess(true)
            this.webDebug = true
          })


      }
      .width('100%')
    }
    .height('100%')
  }
}