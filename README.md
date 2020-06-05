```js
npm i react-native-files-share
```
```js
react-native link react-native-files-share
```

```js
import ShareImages from 'react-native-files-share';
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
* iOS:
![ScreenShot](https://raw.githubusercontent.com/codebetterme/react-native-share/master/example/images/ios_share.png)
* android:
![ScreenShot](https://raw.githubusercontent.com/codebetterme/react-native-share/master/example/images/android_share.png)
