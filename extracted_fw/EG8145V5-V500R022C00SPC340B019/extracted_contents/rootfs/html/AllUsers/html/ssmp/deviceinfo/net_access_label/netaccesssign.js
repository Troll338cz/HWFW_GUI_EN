function getPathImage(permissionIdentifier) {
  var pathImage = '';
  if (permissionIdentifier == 1) {
    pathImage = 'netAccessPermit';
  } else if (permissionIdentifier == 2) {
    pathImage = 'netAccessTrial';
  }
  return pathImage;
}
	
function getDeviceModel(deviceModelLen) {
  var deviceModelType = '';
  if (deviceModelLen <= 25) {
    deviceModelType = 'device-model-short';
  } else if (deviceModelLen <= 32) {
    deviceModelType = 'device-model-long';
  }
  return deviceModelType;
}
