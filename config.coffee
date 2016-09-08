
config = {}
config.base = path.resolve()

# Default settings
config.wordpress =
  host:        "localhost"
  version:     "latest"
  folder:      "#{config.base}/wordpress"
  themeName:   "THEME"
  liveReload:  true
  browserSync: true
  css:         "sass"
  plugins:     []


# TODO: remove the hardcoding of the theme path
# Override the initial configuration with the user defined configuration (config.coffee)
if fs.existsSync "#{config.base}/theme/config.coffee"
  userConfig = require "#{config.base}/theme/config"
  config.wordpress = objectMerge(config.wordpress, userConfig)

config.wordpress.theme =
  src:  "#{config.base}/theme"
  dest: "#{config.wordpress.folder}/wp-content/themes/#{config.wordpress.themeName}"

config.app =
  src: "#{config.wordpress.theme.src}/app"
  dest: config.wordpress.theme.dest

config.php =
  src:  "#{config.wordpress.theme.src}/php"
  dest: config.wordpress.theme.dest

cssType = if config.wordpress.css == "sass" then "sass" else "less"

config.css =
  base: "#{config.wordpress.theme.src}/stylesheets/"
  src:  "#{config.wordpress.theme.src}/stylesheets/#{cssType}"

config.js =
  src:    "#{config.wordpress.theme.src}/javascripts/js"
  coffee: "#{config.wordpress.theme.src}/javascripts/coffee"

config.images =
  src:  "#{config.wordpress.theme.src}/images"
  dest: "#{config.wordpress.theme.dest}/images/"


# Make the config variable globally available
module.exports = config
