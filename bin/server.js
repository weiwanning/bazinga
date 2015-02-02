#!/usr/bin/env node
require('coffee-script/register');
var app = require('./../src/app');

var server = app.listen(process.env.PORT || 5000, function() {
  console.log('Server listening on port ' + server.address().port);
});