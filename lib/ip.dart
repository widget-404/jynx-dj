// ignore_for_file: prefer_const_declarations

import 'dart:convert';

final ip = 'https://api.tiffinboxcompany.com/kitchen/v1';
final basicAuth = 'Basic ' + base64Encode(utf8.encode('admin:test123'));

final headerJson = {
  'authorization': basicAuth,
  'X-API-KEY': 'misbah123',
};
// 'Content-Type': 'application/json',
// 'Content-Type': 'application/json; charset=UTF-8',

final testIP = 'http://kaspar.eastus.cloudapp.azure.com/jynx_testing/api';

// 'http://kaspar.eastus.cloudapp.azure.com/jynx_testing/api';
//final testIP = "http://kaspar.eastus.cloudapp.azure.com/tiffinbox/rider";
final prodIP = 'https://jynx.co.za/api';
