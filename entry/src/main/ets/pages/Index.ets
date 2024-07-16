import { common } from '@kit.AbilityKit';
import { util } from '@kit.ArkTS';
import { Prompt } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  private userInfo: string = '';

  aboutToAppear(): void {
    let context = getContext(this) as common.UIAbilityContext;
    let resourceManager = context.resourceManager;
    let textDecoderOptions: util.TextDecoderOptions = {
      fatal: false,
      ignoreBOM: true
    }
    let decodeWithStreamOptions: util.DecodeWithStreamOptions = {
      stream: false
    }
    resourceManager.getRawFileContent('user_data.json').then(value => {
      let rawFile = value;
      let textDecoder = util.TextDecoder.create('utf-8', textDecoderOptions);
      this.userInfo = textDecoder.decodeWithStream(rawFile, decodeWithStreamOptions);
    })
  }

  build() {
    RelativeContainer() {
      Button('读取 json 文件')
        .onClick(() => {
          Prompt.showToast({
            message: this.userInfo,
            duration: 8000,
          })
        })
    }
  }
}