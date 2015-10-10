#!/usr/bin/env node
// -*- mode: js -*-
"use strict";

var glob = require('glob');
var path = require('path');
var fs = require('fs');
var babel = require('babel-core');
var assign = require('object-assign');

var babelRewriteRequires = require('fbjs-scripts/babel/rewrite-modules');
var babelDevExpression = require('fbjs-scripts/babel/dev-expression');

var moduleMap = assign(
  // All of this could go away if React also ships a module_map.json file.
  {
    React: 'react',
    isEventSupported: 'react/lib/isEventSupported',
    cloneWithProps: 'react-addons-clone-with-props',
    ReactComponentWithPureRenderMixin: 'react-addons-pure-render-mixin',
  },
  require('fbjs/module-map')
);

var internalPath = path.join(__dirname, '../internal');
if (!fs.existsSync(internalPath)) {
  fs.mkdirSync(internalPath);
}

var providesModuleRegex = /@providesModule ([^\s*]+)/;

var babelConf = JSON.parse(
  fs.readFileSync('.babelrc', {encoding: 'utf8'})
);

babelConf.plugins.push(babelRewriteRequires, babelDevExpression);
babelConf._moduleMap = moduleMap;

function processFile(fileName) {
  // Note: Could probably skip the providesModule check, but not sure.
  // If so you could just call babael directly with a file and path output to.
  var contents = fs.readFileSync(fileName, {encoding: 'utf8'});
  var providesModule = providesModuleRegex.exec(contents);
  if (providesModule) {
    contents = babel.transform(contents, babelConf).code;
    fs.writeFileSync(
      path.join(internalPath, providesModule[1] + '.js'),
      contents
    );
  }
}

glob.sync(path.join(__dirname, '../src/**/*.js')).forEach(processFile);
