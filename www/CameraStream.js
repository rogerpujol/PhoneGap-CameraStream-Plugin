var exec = require('cordova/exec');
/**
 * Constructor
 */
function CameraStream() {}

CameraStream.prototype.start = function() {
  exec(function(result){
      // result handler
      alert(result);
    },
    function(error){
      // error handler
      alert("Error" + error);
    },
    "CameraStream",
    "start",
    []
  );
}

var CameraStream = new CameraStream();
module.exports = cameraStream;