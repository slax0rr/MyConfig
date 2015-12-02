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
var Converter={apply:function(){try{this._isConversionRequired()&&(trackEvent("system","convert_version",null,this._getCurrentExtensionVersion()),this._convert())}catch(a){if(1==ExtOptions.debugMode)throw a}},_isConversionRequired:function(){return this._getCurrentExtensionVersion()!=this._getCurrentDataVersion()},_getCurrentExtensionVersion:function(){return ExtOptions.version},_getCurrentDataVersion:function(){var a=new PerfectPixelModel({id:1});return a.fetch(),a.get("version")},_convert:function(){var a=this._getCurrentDataVersion(),b=this._getCurrentExtensionVersion();a==this.LEGACY_VERSION_NUM?VersionConverter_FromLegacy.convert(a,b):(a>=1.5||0==a)&&VersionConverter_SimpleVersionUpdater.convert(a,b)}};