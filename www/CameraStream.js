var exec = require('cordova/exec');
/**
 * Constructor
 */
function CameraStream() {}

CameraStream.prototype.start = function(successFunction,errorFunction) {
  var args = [];
  exec(successFunction,errorFunction,"CameraStream","start",args);
};
CameraStream.prototype.getData = function(successFunction,errorFunction) {
  var args = [];
  exec(successFunction,errorFunction,"CameraStream","getData",args);
};

var cameraStream = new CameraStream();
module.exports = cameraStream;