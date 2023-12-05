import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button("go to webview")
          .onClick(() => {
            router.pushUrl({ url: "pages/WebComponent" })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}