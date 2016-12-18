module.exports = function(grunt) {

    // Project configuration.
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        "file-creator": {
            "logs": {
                "logs/accessibility_data.json": function (fs, fd, done) {
                    fs.writeSync(fd, '[]');
                    done();
                },
                "logs/html_data.json": function (fs, fd, done) {
                    fs.writeSync(fd, '[]');
                    done();
                }
            }
        }
    });

    grunt.loadNpmTasks('grunt-file-creator');

    // Default task(s).
    // grunt.registerTask('default', 'Create local logs', function() {
    //
    // });
    grunt.registerTask('create', ['file-creator:logs']);
};