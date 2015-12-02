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
var PPFile=function(){this.ArrayBuffer=null,this.Name=null,this.MimeType=null,this.Date=null,this.ToBlob=function(){var a=new DataView(this.ArrayBuffer);return new Blob([a],{type:this.MimeType})}},PPFileManager=new function(){this.fs=null,this.Init=function(a){this.fs?a():(window.requestFileSystem=window.requestFileSystem||window.webkitRequestFileSystem,window.requestFileSystem(window.PERSISTENT,524288e3,function(b){PPFileManager.fs=b,a()},function(b){PPFileManager._errorHandler(b),a(PPFileManager._generateFileSystemErrorMsg())}))},this.GetFile=function(a,b){return this.fs?void this.fs.root.getFile(a,{},function(a){a.file(function(a){var c=new FileReader;c.onerror=function(a){PPFileManager._errorHandler(a),b()},c.onloadend=function(){var c=new PPFile;if(c.ArrayBuffer=this.result,c.Name=a.name,c.MimeType=a.type,c.Date=a.lastModifiedDate,settings.get("enableStatistics")){var d=a.size;trackEvent("filemanager","getfile",d,"size")}b(c)},c.readAsArrayBuffer(a)},function(a){PPFileManager._errorHandler(a),b()})},function(a){PPFileManager._errorHandler(a),b()}):void b(PPFileManager._generateFileSystemErrorMsg())},this.SaveFile=function(a,b){if(!this.fs)return void b(PPFileManager._generateFileSystemErrorMsg());var c=Math.floor(1e14*Math.random())+"_"+a.Name,d=a.ToBlob();this.fs.root.getFile(c,{create:!0},function(e){e.createWriter(function(f){f.onwriteend=function(){if(a.Name=c,a.Date=e.lastModifiedDate,settings.get("enableStatistics")){var d=this.length;trackEvent("filemanager","savefile",d,"size")}b(a)},f.write(d)},function(a){PPFileManager._errorHandler(a),b()})},function(a){PPFileManager._errorHandler(a),b()})},this.DeleteFile=function(a,b){return this.fs?void this.fs.root.getFile(a,{create:!1},function(a){a.remove(function(){settings.get("enableStatistics")&&trackEvent("filemanager","deletefile"),b()},function(a){PPFileManager._errorHandler(a),b()})},function(a){PPFileManager._errorHandler(a),b()}):void b(PPFileManager._generateFileSystemErrorMsg())},this.DeleteFiles=function(a,b){var c=[],d=100500;$.isArray(a)||(a=[a]);for(var e=0;e<a.length;e++){var f=e;this.DeleteFile(a[f],function(){c.push(d),c.length==a.length&&b()})}},this._GetAllFiles=function(a){var b=this.fs.root.createReader();b.readEntries(function(b){a(b)},function(b){PPFileManager._errorHandler(b),a()})},this._DeleteAllFiles=function(){var a=this.fs.root.createReader();a.readEntries(function(a){0==a.length;for(var b,c=0;b=a[c];++c)b.remove(function(){},PPFileManager._errorHandler)},PPFileManager._errorHandler)},this._errorHandler=function(a){PPFileManager._getFileErrorMsg(a)},this._getFileErrorMsg=function(a){var b="";switch(a.code){case FileError.QUOTA_EXCEEDED_ERR:b="QUOTA_EXCEEDED_ERR";break;case FileError.NOT_FOUND_ERR:b="NOT_FOUND_ERR";break;case FileError.SECURITY_ERR:b="SECURITY_ERR";break;case FileError.INVALID_MODIFICATION_ERR:b="INVALID_MODIFICATION_ERR";break;case FileError.INVALID_STATE_ERR:b="INVALID_STATE_ERR";break;default:b="Unknown Error"}return b},this._generateFileSystemErrorMsg=function(){return{showToUser:!0,message:"ERROR: Cannot open filesystem.\r\nPlease use Storage compatibility mode in options.\r\n\r\nPossible reason: user's profile directory path contains non-latin characters (http://code.google.com/p/chromium/issues/detail?id=94314)"}}};