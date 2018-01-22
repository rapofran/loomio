# writes dist/javascripts/plugin(.min).js
paths    = require './paths'
onError  = require './onerror'
gulp     = require 'gulp'
pipe     = require 'gulp-pipe'
plumber  = require 'gulp-plumber'
coffee   = require 'gulp-coffee'
append   = require 'add-stream'
replace  = require 'gulp-replace'
sass     = require 'gulp-sass'
haml     = require 'gulp-haml'
htmlmin  = require 'gulp-htmlmin'
template = require 'gulp-angular-templatecache'
concat   = require 'gulp-concat'
rename   = require 'gulp-rename'

module.exports =
  coffee: ->
    pipe gulp.src(paths.plugin.coffee), [
      plumber(errorHandler: onError),                 # handle errors gracefully
      coffee(bare: true),                             # convert from coffeescript to js
      append.obj(pipe gulp.src(paths.plugin.haml), [  # build html template cache
        haml(),                                       # convert haml to html
        htmlmin(),                                    # minify html
        template(                                     # store html templates in angular cache
          module: 'loomioApp',
          transformUrl: (url) ->
            if url.match /.+\/.+/
              "generated/components/#{url}"
            else
              "generated/components/#{url.split('.')[0]}/#{url}"
        ),
      ]),
      concat('plugin.js'),                        # concatenate app files
      gulp.dest(paths.dist.assets)                # write assets/plugin.js
    ]

  scss: ->
    pipe gulp.src(paths.plugin.scss), [
      plumber(errorHandler: onError),                # handle errors gracefully
      replace('screen\\0','screen'),                 # workaround for https://github.com/angular/material/issues/6304
      concat('plugin.css'),                          # concatenate scss files
      sass(includePaths: paths.plugin.scss_include), # convert scss to css (include vendor path for @imports)
      gulp.dest(paths.dist.assets)                   # write assets/plugin.css
    ]
