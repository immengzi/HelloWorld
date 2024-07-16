import { common } from '@kit.AbilityKit';
import { util } from '@kit.ArkTS';
import { Prompt } from '@kit.ArkUI';
import { UserInfo } from '../model/UserInfo';

@Entry
@Component
struct Index {
  private userInfo: UserInfo[] = [];

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
      let decodedText = textDecoder.decodeWithStream(rawFile, decodeWithStreamOptions);
      this.userInfo = JSON.parse(decodedText) as UserInfo[];
    })
  }

  build() {
    RelativeContainer() {
      Button('读取 json 文件')
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          Prompt.showToast({
            message: JSON.stringify(this.userInfo, null, 2),
            duration: 8000,
          });
        });
    }
  }
}