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
function togglePanel(a){this.panelView?this.panelView.isFrozen()?this.panelView.unfreeze():this.panelView.freeze():ExtensionService.sendMessage({type:PP_RequestType.GetExtensionOptions},$.proxy(function(b){if(ExtOptions=b,!ExtOptions.debugMode){window.console||(window.console={});for(var c=["log","debug","warn","info","time","timeEnd"],d=0;d<c.length;d++)console[c[d]]=function(){}}Converter.apply(),PerfectPixel=new PerfectPixelModel({id:1}),this.panelView=new PanelView({state:a})},this))}var ExtOptions,PerfectPixel,trackEvent=function(a,b,c,d){0!=ExtOptions.enableStatistics&&ExtensionService.sendMessage({type:PP_RequestType.TrackEvent,senderId:a,eventType:b,integerValue:c,stringValue:d},function(a){})};ExtensionService.onMessage.addListener(function(a){a.type==PP_Background_RequestType.NotificationsUpdated&&PerfectPixel.notificationModel.initialize()});