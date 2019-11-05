
```js
import ShareImages from 'react-native-images-share';
```

Showing the ActivityView for iOS is as simple as calling:
```js
ShareImages.show({
  images: [''], // list images base64
  exclude: [''],
  anchor: React.findNodeHandle(this.refs.share)
});
```
#### Note:
`images` is list base64 of images. Example: ['3hG2424HYu23...', 'Hy234hhj234g...', ...]
