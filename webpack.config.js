var ExtractTextPlugin = require("extract-text-webpack-plugin");
var CopyWebpackPlugin = require("copy-webpack-plugin");
var autoprefixer = require("autoprefixer");

module.exports = {
  devtool: "source-map",
  entry: {
    "client": ["./web/static/css/client.less", "./web/static/js/client.js"],
  },

  output: {
    path: "./priv/static",
    filename: "js/client.js"
  },

  resolve: {
    modulesDirectories: [
      __dirname + "/web/static/js",
      'node_modules'
    ],
    alias: {
      phoenix: __dirname + "/deps/phoenix/web/static/js/phoenix.js"
    }
  },

  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: "babel",
        query: {
          presets: ['es2015']
        }
      }, {
        test: /\.css$/,
        loader: ExtractTextPlugin.extract("style", "css")
      }, {
        test: /\.less$/,
        loader: ExtractTextPlugin.extract(
          "style",
          "css!postcss!less?includePaths[]=" + __dirname +  "/node_modules"
        )
      }
    ]
  },

  postcss: [autoprefixer({
    browsers: ['last 2 version', 'Opera >= 12', 'ie >= 9'],
    remove: false
  })],

  plugins: [
    new ExtractTextPlugin("css/client.css"),
    new CopyWebpackPlugin([
      { from: "./web/static/assets" },
      { from: "./deps/phoenix_html/web/static/js/phoenix_html.js",
        to: "js/phoenix_html.js" }
    ])
  ]
}