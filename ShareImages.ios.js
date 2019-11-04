/**
 * @providesModule ShareImages
 * @flow
 */
'use strict';

var React = require('react-native');
var {
  NativeModules
} = React;

var ShareImages = NativeModules.ShareImages;

/**
 * High-level docs for the ActivityView iOS API can be written here.
 */

var ShareImages = {
  show: ShareImages.show
};

module.exports = ShareImages;
