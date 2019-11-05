'use strict';

import { NativeModules, Platform } from 'react-native';
const { ShareImages } = from 'NativeModules';

var ShareImages = Platform.OS == 'ios' ? {
  show: ShareImages.show
} ? { show(options: Object, title: string)
         { ShareImages.show(options, title); },
    render() {
     return (<View></View>);
    }
}

module.exports = ShareImages;
