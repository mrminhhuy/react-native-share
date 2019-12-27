```js
npm i react-native-images-share
```

```js
import ShareImages from 'react-native-images-share';
```

Simple as calling:
```js
ShareImages.show({
  images: [''], // list images base64 or pdf base64
  exclude: [''],
  isPDF: true | false
});
```
#### Note:
`images` is list base64 of images. Example: ['3hG2424HYu23...', 'Hy234hhj234g...', ...]
#### Example:
Try an example in repos.
This is some screenshots:
- Share button
* iOS:
![ScreenShot](https://raw.githubusercontent.com/codebetterme/react-native-share/master/example/images/img_ios_home.png)
* android:
![ScreenShot](https://raw.githubusercontent.com/codebetterme/react-native-share/master/example/images/img_android_home.png)
- Share View
* iOS:
![ScreenShot](https://raw.githubusercontent.com/codebetterme/react-native-share/master/example/images/img_ios_share.png)
* android:
![ScreenShot](https://raw.githubusercontent.com/codebetterme/react-native-share/master/example/images/img_android_share.png)
