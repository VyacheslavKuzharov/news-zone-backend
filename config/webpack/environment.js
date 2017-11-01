const { environment } = require('@rails/webpacker');
const webpack = require('webpack');

// Add an additional plugin of your choosing : ProvidePlugin
environment.plugins.set(
    'Provide',
    new webpack.ProvidePlugin({
        $: 'jquery',
        jQuery: 'jquery',
        jquery: 'jquery',
        Popper: ['popper.js', 'default']
    })
);

module.exports = environment;
