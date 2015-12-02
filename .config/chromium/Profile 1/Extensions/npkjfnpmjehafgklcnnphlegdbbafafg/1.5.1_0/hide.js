( function() {
    var hide = [ "img", "embed", "object", "canvas" ],
        removeBackground = [ "span", "div", "h6", "h5", "h4", "h3", "h2", "h1", "dl", "dt", "ul",  "ol",  "li",  "a",  "body",  "html", "p", "article", "section", "header", "footer", "figure", "i", "b", "em", "strong", "aside", "main", "nav" ],
        traverseTagTypes = function( types, func ) {
            for( var i = types.length - 1; i >= 0; i-- ) {
                runOnAllTagsOfType( types[ i ], func );
            }
        },
        runOnAllTagsOfType = function( tagName, func ) {
            var els = document.getElementsByTagName( tagName );
            if( els ) {
                for (var i = els.length - 1; i >= 0 ; i-- ) {
                    func.call( undefined, els[ i ] );
                }
            }
        },
        doHide = function( el ) {
            el.style.visibility = "hidden";
        },
        doRemoveBackground = function( el ) {
            var noUrl = "url('')";

            el.style.backgroundImage = noUrl;
            el.style.background = noUrl;
            el.backgroundImage = noUrl;
            el.background = noUrl;
        },
        doHideIframes = function( el ) {
            el.src = "";
        };

    traverseTagTypes( hide, doHide );

    traverseTagTypes( removeBackground, doRemoveBackground );

    runOnAllTagsOfType( "iframe", doHideIframes );
} )();
