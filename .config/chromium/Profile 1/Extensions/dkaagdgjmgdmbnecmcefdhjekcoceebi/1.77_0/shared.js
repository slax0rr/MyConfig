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
function bufferToString(a){var b=new Uint8Array(a);return Array.prototype.join.call(b,",")}function stringToBuffer(a){var b=a.split(","),c=new Uint8Array(b);return c.buffer}var PP_RequestType=new function(){this.GetExtensionOptions="GETEXTOPTIONS",this.TrackEvent="TRACKEVENT",this.ADDFILE="ADDFILE",this.GETFILE="GETFILE",this.DELETEFILE="DELETEFILE",this.getTabId="GETTABID",this.PanelStateChange="PANELSTATECHANGE",this.GetNotifications="GETNOTIFICATION",this.SetNotifications="SETNOTIFICATION",this.ExecuteScript="EXECUTESCRIPT",this.OpenSettingsPage="OPENSETTINGSPAGE"},PP_Background_RequestType=new function(){this.NotificationsUpdated="NotificationsUpdated"};