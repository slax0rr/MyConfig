var availableLocales = ['en', 'am', 'ar', 'bg', 'ca', 'cs', 'da', 'de', 'el', 'en_GB', 'es', 'es_419', 'et', 'fa', 'fi', 'fil', 'fr', 'hi', 'hr', 'hu', 'id', 'it', 'iw', 'ja', 'ko', 'lt', 'lv', 'ms', 'nl', 'no', 'pl', 'pt_BR', 'pt_PT', 'ro', 'ru', 'sk', 'sl', 'sr', 'sv', 'sw', 'th', 'tr', 'uk', 'vi', 'zh_CN', 'zh_TW', 'zu']; var availableRtlLocales = ['ar', 'fa', 'iw']; var prefix = 'keep_prod'; _docs_flag_initialData={"n_amt":["audio/aac","image/jpeg","image/png","image/gif"],"n_k":"AIzaSyDzSyl-DPNxSyc7eghRsB4oNNetrnvnH0I","n_als":"https://www.googleapis.com/auth/offers.lmp","n_ars":"https://www.googleapis.com/auth/reminders","n_s":"https://www.googleapis.com/auth/memento","n_ss":"https://www.googleapis.com/auth/drive,https://www.googleapis.com/auth/plus.peopleapi.readwrite","n_ats":"https://www.googleapis.com/auth/client_channel","n_v":"v1","n_bau":"https://www.googleapis.com/","n_bu":"https://drive.google.com/otservice/","n_cbmv":2,"n_cc":"TR, EC, SH, LB, RB","n_c":"192748556389-u13aelnnjsmn5df1voa2d3oimlbd8led.apps.googleusercontent.com","n_csbs":120,"csi":false,"n_cn":"","n_dt":"","n_deau":"https://www.googleapis.com/","n_earow":true,"n_ecm":false,"n_eetm":false,"n_emog":false,"n_ep":true,"n_evs":true,"n_evt":true,"n_imb":10485760,"n_imp":26214400,"n_lcu":false,"n_lmau":"https://www.googleapis.com/","n_mpau":"https://maps.googleapis.com/maps/api/place/","n_iu":"https://keep.google.com/media/","n_nmri":5000,"n_nib":5000,"n_nmb":1800000,"n_oe":true,"n_pau":"https://www.googleapis.com/","n_rau":"https://www.googleapis.com/","n_scp":false,"n_sit":["image/jpeg","image/png","image/gif"],"n_t":true,"n_tc":1032,"n_tu":"https://client-channel.google.com/client-channel/channel","n_tsu":"https://clients4.google.com/invalidation/lcs/request","n_ts":1032,"n_tmd":7,"n_ur":"edit","n_ugat":true,"n_uo":true,"n_uo2":true,"n_wfp":false,"n_wcv":"3.1.3.0"};
var langSynonyms = {
  'he': 'iw',
}
var locale = window.navigator.language;
if (langSynonyms[locale]) {
  locale = langSynonyms[locale];
}

var jsbundle = availableRtlLocales.indexOf(locale) >= 0 ?
    'app_rtl.js' : 'app_ltr.js';
var jsel = document.createElement('script');
jsel.setAttribute('type', 'text/javascript');
jsel.setAttribute('src', prefix + jsbundle);

var cssBundle = availableRtlLocales.indexOf(locale) >= 0 ?
    'rtl.css' : 'ltr.css';
var cssEl = document.createElement('link');
cssEl.setAttribute('rel', 'stylesheet');
cssEl.setAttribute('href', prefix + cssBundle);

var symbolsBundle = availableLocales.indexOf(locale) >= 0 ? locale : 'en';
var symbolsEl = document.createElement('script');
symbolsEl.setAttribute('type', 'text/javascript');
symbolsEl.setAttribute('src', 'i18n/symbols_' + symbolsBundle + '.js');

var head = document.getElementsByTagName('head')[0];
head.appendChild(symbolsEl);
head.appendChild(cssEl);
head.appendChild(jsel);

jsel.onload = function() {
  initNotesApp(true);
};
