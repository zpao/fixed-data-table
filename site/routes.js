var Router = require('react-router');
var {Route, RouteHandler, DefaultRoute} = Router;

var React = require('react');
var Router = require('react-router');
var IndexPage = require('./IndexPage');
var HomePage = require('./home/HomePage');
var TableAPIPage = require('./docs/TableAPIPage');
var ColumnAPIPage = require('./docs/ColumnAPIPage');
var ColumnGroupAPIPage = require('./docs/ColumnGroupAPIPage');
var ExamplesPage = require('./examples/ExamplesPage');

module.exports = (
  <Route name="index" path="/" handler={IndexPage}>
    <DefaultRoute handler={HomePage} />
  </Route>
)