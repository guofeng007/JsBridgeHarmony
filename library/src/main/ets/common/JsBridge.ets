import webview from '@ohos.web.webview';

export type JsCallback = (result: string) => void;
export type NativeFunction = (params: string, callback: JsCallback) => void;


export class JsBridge {
  private static instance: JsBridge;
  private map: Map<string, NativeFunction>;

  private constructor() {
    this.map = new Map<string, NativeFunction>();
  }

  public static getInstance(): JsBridge {
    if (!JsBridge.instance) {
      JsBridge.instance = new JsBridge();
    }
    return JsBridge.instance;
  }

  register(key: string, func: NativeFunction): void {
    this.map.set(key, func);
  }

  unregister(key: string): void {
    this.map.delete(key);
  }

  removeAll(): void {
    this.map.clear();
  }

  call(key: string, params: string, controller: webview.WebviewController): void {
    const func = this.map.get(key);
    if (func) {
      func(params, (result: string) => {
        controller.runJavaScript("callH5Method('"+result+"');");
      });
    }
  }
}
