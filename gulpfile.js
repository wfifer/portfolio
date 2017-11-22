var config = require('./config.json');

var gulp = require('gulp'),
	fs = require('fs'),
	del = require('del'),
	path = require('path'),
	gulpif = require('gulp-if'),
	gutil = require('gulp-util'),
	gulpImports = require('gulp-imports'),
	jshint = require('gulp-jshint'),
	sass = require('gulp-sass'),
	sassGlob = require('gulp-sass-glob'),
	cssnano = require('gulp-cssnano'),
	sourcemaps = require('gulp-sourcemaps'),
	concat = require('gulp-concat'),
	uglify = require('gulp-uglify'),
	rename = require('gulp-rename'),
	notify = require('gulp-notify'),
	autoprefixer = require('gulp-autoprefixer'),
	svgstore = require('gulp-svgstore'),
	imagemin = require('gulp-imagemin'),
	cheerio = require('gulp-cheerio'),
	plumber = require('gulp-plumber'),
	twig = require('gulp-twig'),
	babel = require('gulp-babel');


var buildOptions = {
		prod: gutil.env.prod, // use gulp --prod for minification
	};

var onCompileError = function (err) {
	gutil.log(err);
	notify.onError({
		title: 'Gulp',
		subtitle: 'Compile Error!',
		message: '<%= error.message %>',
		sound: 'Beep'
	})(err);
	gutil.log(gutil.colors.red(err));

	// Keep gulp from hanging on this task
	if (typeof this.emit === 'function') this.emit('end')
};

var onJSHintError = function (err) {
	notify.onError({
		title: 'Gulp',
		subtitle: 'JS Error!',
		message: '<%= error.message %>',
		sound: 'Beep'
	})(err);

	// Keep gulp from hanging on this task
	if (typeof this.emit === 'function') this.emit('end')
};

gulp.task('build-css', function () {
	return gulp.src(config.paths.styles.src + 'main.scss')
		.pipe(plumber({ errorHandler: onCompileError }))

		// Include sourcemaps if gulp runs with '--type prod'
		// .pipe(gulpif(!buildOptions.prod, sourcemaps.init()))

		// allow @import "sections/*"; in main scss file rather than named imports
		.pipe(sassGlob())
		.pipe(sass())
		.pipe(autoprefixer({ browsers: ['> 1%', 'ios_saf 6', 'ie >= 9'], map: true }))

		// Minify if gulp runs with '--prod'
		.pipe(gulpif(buildOptions.prod, cssnano({ autoprefixer: false })))
		// .pipe(gulpif(!buildOptions.prod, sourcemaps.write()))

		.pipe(rename('styles.css'))
		.pipe(gulp.dest(config.paths.styles.dist))
		.pipe(notify('SASS Complete'));
});

gulp.task('jshint', function () {
	return gulp.src(config.paths.scripts.src + 'components/**/*.js')
		.pipe(plumber({ errorHandler: onJSHintError }))
		.pipe(jshint({ esversion: 6 }))
		.pipe(jshint.reporter('jshint-stylish'))
		.pipe(jshint.reporter('fail'))
		.on('error', notify.onError({ message: 'JS hint fail' }));
});

gulp.task('build-js-dependencies', function () {
	return gulp.src(config.paths.scripts.src + 'dependencies.js')
		.pipe(plumber({ errorHandler: onCompileError }))
		// .pipe(sourcemaps.init())
		.pipe(gulpImports())
		.pipe(concat('dependencies.js'))

		// Uglify if gulp runs with '--prod'
		.pipe(gulpif(buildOptions.prod, uglify()))
		// .pipe(gulpif(!buildOptions.prod, sourcemaps.write()))

		.pipe(gulp.dest(config.paths.scripts.dist))
		.pipe(notify('JS Dependencies Complete'));
});

gulp.task('build-js-components', function () {
	return gulp.src(config.paths.scripts.src + 'components.js')
		.pipe(plumber({ errorHandler: onCompileError }))
		// .pipe(sourcemaps.init())

		.pipe(gulpImports())
		.pipe(babel({
			presets: ['env']
        }))

		// Uglify if gulp runs with '--prod'
		.pipe(gulpif(buildOptions.prod, uglify()))
		// .pipe(gulpif(!buildOptions.prod, sourcemaps.write()))

		.pipe(rename('scripts.js'))
		.pipe(gulp.dest(config.paths.scripts.dist))
		.pipe(notify('JS Components Complete'));
});

// Optimise and copy Images from src to dist
gulp.task('imagemin', function () {
	return gulp.src(config.paths.images.src + '**/*.{jpg,png,gif,svg}')
		.on('error', onCompileError)
		.pipe(imagemin({
			progressive: true,
			interlaced: true,
			pngquant: true
		}))
		.pipe(gulp.dest(config.paths.images.dist))
		.pipe(notify('Images optimised'));
})

// Compile SVG symbols into a single file for includes
gulp.task('svgstore', ['imagemin'], function () {
	return gulp.src(config.paths.images.dist + 'svg/svg-symbols/*.svg')
		.on('error', onCompileError)
		.pipe(svgstore({ inlineSvg: true }))
		.pipe(cheerio({
			run: function ($, file) {
				$('svg').attr({
					style: 'height: 0; width: 0; position: absolute; visibility: hidden;',
					tabindex: '-1'
				});
				$('symbol').attr('preserveAspectRatio', 'xMinYMin slice');
			},
			parserOptions: { xmlMode: true }
		}))
		.pipe(rename('svg-symbols.html'))
		.pipe(gulp.dest(config.paths.templates.src + '_snippets/'))
		.pipe(notify('SVG symbols compiled')); 
});

// Compile templates from src to dist
// gulp.task('templates', ['imagemin', 'svgstore'], function () {
// 	gulp.src(config.paths.templates.src + "*/*.html")
// 		.pipe(rename(function (path) {
//             path.extname = '.twig'
//         }))
//         .pipe(gulp.dest(config.paths.templates.dist + 'assets/templates/'));

// 	return gulp.src(config.paths.templates.src + 'index.html')
// 		.on('error', onCompileError)
// 		.pipe(twig())
// 		.on('error', onCompileError)
// 		// .pipe(rename('stylefile.html'))
// 		.pipe(gulp.dest(config.paths.templates.dist))
// 		.pipe(notify('Templates Complete'));
// });

gulp.task('watch', function () {
	gulp.watch(config.paths.images.src + '**/*.{jpg, png, gif, svg}', ['imagemin', 'svgstore']);
	gulp.watch(config.paths.scripts.src + '**/*.js', ['jshint', 'build-js']);
	gulp.watch(config.paths.styles.src + '**/*.scss', ['build-css']);
	// gulp.watch(config.paths.templates.src + '**/*.html', ['templates']);
});

var defaultTasks = ['imagemin', 'svgstore', /*'templates',*/ 'build-css', 'build-js'];
// Only watch when not using --prod
if (!buildOptions.prod) defaultTasks.push('watch');

gulp.task('build-js', ['jshint', 'build-js-dependencies', 'build-js-components']);
gulp.task('default', defaultTasks);