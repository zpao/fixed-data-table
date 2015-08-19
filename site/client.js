"use strict";

var React = require('react');
var Router = require('react-router');

var routes = require('./routes');

Router.run(routes, Router.HistoryLocation, (Page) => {
  React.render(
    <Page
      {...window.INITIAL_PROPS}
    />,
    document
  );
});
