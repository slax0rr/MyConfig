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
var ExtensionService={sendMessage:function(){return chrome.runtime.sendMessage.apply(chrome,arguments)},getResourceUrl:function(){return chrome.extension.getURL.apply(chrome,arguments)},getLocalizedMessage:function(){return chrome.i18n.getMessage.apply(chrome,arguments)},onMessage:{addListener:function(){chrome.runtime.onMessage.addListener.apply(chrome.runtime.onMessage,arguments)}}};