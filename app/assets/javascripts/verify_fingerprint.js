//= require fingerprint2

(function (exports) {
   'use strict';

    // based on jQuery's param implementation https://github.com/jquery/jquery/blob/master/src/serialize.js
    function serialiseComponents(components) {
        var componentsToExclude = ['webgl'];
        var r = [];
        jQuery.each(components, function() {
            if(componentsToExclude.indexOf(this.key) == -1) {
                r[r.length] = encodeURIComponent(this.key) + "=" + encodeURIComponent(this.value);
            }
        });
        return r.join("&");
    }

    function reportFingerprint(path, epoch, imageElement) {
        // disabling javascript font parsing, this is very slow, and the canvas because it yields a different fingerprint for the first page loaded
        var options = {excludeJsFonts: true, excludeCanvas: true};
        new Fingerprint2(options).get(function(result, components){
            imageElement.src = path + '?hash='+epoch+'-'+result+'&cache_bust='+(new Date().getTime())+'&components='+serialiseComponents(components);
        });
    }

    exports.reportFingerprint = reportFingerprint;
})(this);
