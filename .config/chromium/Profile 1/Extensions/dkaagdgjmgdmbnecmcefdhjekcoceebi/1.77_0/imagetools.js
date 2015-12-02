/*

Copyright 2011-2015 Alex Belozerov, Ilya Stepanov

This file is part of PerfectPixel.

PerfectPixel is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

PerfectPixel is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with PerfectPixel.  If not, see <http://www.gnu.org/licenses/>.

*/
var PPImageTools=new function(){this.createBlobUrl=function(a){var b;return window.createObjectURL?b=window.createObjectURL(a):window.createBlobURL?b=window.createBlobURL(a):window.URL&&window.URL.createObjectURL?b=window.URL.createObjectURL(a):window.webkitURL&&window.webkitURL.createObjectURL&&(b=window.webkitURL.createObjectURL(a)),b},this.revokeBlobUrl=function(a){window.revokeObjectURL?window.revokeObjectURL(a):window.revokeBlobURL?window.revokeBlobURL(a):window.URL&&window.URL.revokeObjectURL?window.URL.revokeObjectURL(a):window.webkitURL&&window.webkitURL.revokeObjectURL&&window.webkitURL.revokeObjectURL(a)},this.ResizeBlob=function(a,b,c,d){var e=a,f=a.type,g=new FileReader;g.onloadend=function(){var a=document.createElement("img");a.onload=function(){var e=a.width,g=a.height,h=c/b;e*h>g?(e*=c/g,g=c):(g*=b/e,e=b);var i=document.createElement("canvas");i.width=e,i.height=g;var j=i.getContext("2d");j.drawImage(this,0,0,e,g),i.toBlob(function(b){d(b,a)},f)},a.src=g.result},g.readAsDataURL(e)},this.getArrayBufferFromBlob=function(a,b){var c=new FileReader;c.onloadend=function(a){var c=a.target.result;b(c)},c.readAsArrayBuffer(a)}};