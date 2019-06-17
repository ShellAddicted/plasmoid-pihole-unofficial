
Qt.include('sjcl.js');

function getSha256asHex(data) {
  let bitArray = sjcl.hash.sha256.hash(data);
  return sjcl.codec.hex.fromBits(bitArray);
}

function getDoubleSha256asHex(data) {
  return getSha256asHex(getSha256asHex(data));
}


function cleanStr(data){
  return data === undefined ? "" : data;
}

function handle_api_response(res) {
  if (res.readyState === 4) {
    if (res.status === 200) {
      try {
        let data = JSON.parse(res.responseText);
        summary_data = data;
      } catch (err) {
        print("JSONError:" + err + "=>" + res.responseText);
        summary_data = {'ERR': 'JSONErr'};
      }
    } else {
      print("RequestError:" + res.status);
      summary_data = {"ERR": "NetErr"};
    }
  }
}

function performHttpGET(url, callback) {
  var xhr = new XMLHttpRequest();
  xhr.timeout = 1000;
  xhr.onreadystatechange = () => {
    callback(xhr);
  };
  xhr.open('GET', url, true);
  xhr.send();
}

function togglePiHoleStatus() {
  let action = summary_data.status === 'enabled' ? 'disable' : 'enable';
  let url = plasmoid.configuration.apiurl + '?' + action +
      '&auth=' + plasmoid.configuration.passwordhash;
  performHttpGET(url, () => {});
}