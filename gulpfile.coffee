gulp = require 'gulp'
coffee = require 'gulp-coffee'
rename = require 'gulp-rename'
uglify = require 'gulp-uglify'
requirejs = require 'gulp-requirejs'
amdclean = require 'gulp-amdclean'
del = require 'del'
fs = require 'fs'

dependency = true

src = "./src"
dest = "./build"


srcPath =
    script: src + "/coffee/*.coffee"

destPath =
    script_amd: dest + "/js/amd"
    script_amd_opt: dest + "/js/optimized"
    script_fe: dest + "/js/front-end"
    temp: dest + "/tmp"


gulp.task 'clean', ()->
    del.sync dest

gulp.task 'coffee', ['clean'], ()->
    gulp.src srcPath.script
    .pipe coffee({bare:true})
    .pipe gulp.dest destPath.temp

requireBuild = (cleanAMD, dest)->
    console.log "Start requireJS build"

    jsFiles = requirejs
        baseUrl: destPath.temp
        out: "Zuark.js"
        name: "Zuark"
        packages:[
            name:"lodash"
            location: "../../node_modules/lodash-amd"
        ]

    if cleanAMD
        jsFiles = jsFiles.pipe amdclean.gulp
                'prefixMode': 'standard'
    jsFiles.pipe gulp.dest dest
    .pipe uglify()
    .pipe rename (path)->
        path.extname = ".min.js"
        path
    .pipe gulp.dest dest
    del destPath.temp
    console.log "Finish requireJS build..."


gulp.task 'default',['js']

gulp.task 'amd', ['clean'], ()->
    gulp.src srcPath.script
    .pipe coffee({bare:true})
    .pipe gulp.dest destPath.script_amd

gulp.task 'amd_opt', ['coffee'],()->
    requireBuild(false, destPath.script_amd_opt)

gulp.task 'js', ['coffee'], ()->
    requireBuild(true, destPath.script_fe)

gulp.task 'all',['js','amd','amd_opt']
