var exec = require('cordova/exec');
/**
 * Constructor
 */
function CameraStream() {}

CameraStream.prototype.start = function(successFunction,errorFunction) {
  exec(successFunction,errorFunction,"CameraStream","start",[]);
};

var cameraStream = new CameraStream();
module.exports = cameraStream;