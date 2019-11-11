'use strict';

import { NativeModules, Platform } from 'react-native';
const ShareImages = NativeModules.ShareImages;

var ShareImagesModule = Platform.OS == 'ios' ? {
  show: ShareImages.show
} : {
  show(options: Object) {
      ShareImages.show(options);
    },
    render() {
     return (<View></View>);
    }
}

module.exports = ShareImagesModule;
