var a=this,b=function(m,k){var f=m.split("."),e=a;f[0]in e||!e.execScript||e.execScript("var "+f[0]);for(var g;f.length&&(g=f.shift());)f.length||void 0===k?e=e[g]?e[g]:e[g]={}:e[g]=k};var c={b:{1E3:{other:"0K"},1E4:{other:"00K"},1E5:{other:"000K"},1E6:{other:"0M"},1E7:{other:"00M"},1E8:{other:"000M"},1E9:{other:"0B"},1E10:{other:"00B"},1E11:{other:"000B"},1E12:{other:"0T"},1E13:{other:"00T"},1E14:{other:"000T"}},a:{1E3:{other:"0 thousand"},1E4:{other:"00 thousand"},1E5:{other:"000 thousand"},1E6:{other:"0 million"},1E7:{other:"00 million"},1E8:{other:"000 million"},1E9:{other:"0 billion"},1E10:{other:"00 billion"},1E11:{other:"000 billion"},1E12:{other:"0 trillion"},1E13:{other:"00 trillion"},
1E14:{other:"000 trillion"}}},c={b:{1E3:{other:"0\u0c35\u0c47"},1E4:{other:"00\u0c35\u0c47"},1E5:{other:"000\u0c35\u0c47"},1E6:{other:"0\u0c2e\u0c3f"},1E7:{other:"00\u0c2e\u0c3f"},1E8:{other:"000\u0c2e\u0c3f"},1E9:{other:"0\u0c2c\u0c3f"},1E10:{other:"00\u0c2c\u0c3f"},1E11:{other:"000\u0c2c\u0c3f"},1E12:{other:"0\u0c1f\u0c4d\u0c30\u0c3f"},1E13:{other:"00\u0c1f\u0c4d\u0c30\u0c3f"},1E14:{other:"000\u0c1f\u0c4d\u0c30\u0c3f"}},a:{1E3:{other:"0 \u0c35\u0c47\u0c32\u0c41"},1E4:{other:"00 \u0c35\u0c47\u0c32\u0c41"},
1E5:{other:"000 \u0c35\u0c47\u0c32\u0c41"},1E6:{other:"0 \u0c2e\u0c3f\u0c32\u0c3f\u0c2f\u0c28\u0c4d\u0c32\u0c41"},1E7:{other:"00 \u0c2e\u0c3f\u0c32\u0c3f\u0c2f\u0c28\u0c4d\u0c32\u0c41"},1E8:{other:"000 \u0c2e\u0c3f\u0c32\u0c3f\u0c2f\u0c28\u0c4d\u0c32\u0c41"},1E9:{other:"0 \u0c2c\u0c3f\u0c32\u0c3f\u0c2f\u0c28\u0c4d\u0c32\u0c41"},1E10:{other:"00 \u0c2c\u0c3f\u0c32\u0c3f\u0c2f\u0c28\u0c4d\u0c32\u0c41"},1E11:{other:"000 \u0c2c\u0c3f\u0c32\u0c3f\u0c2f\u0c28\u0c4d\u0c32\u0c41"},1E12:{other:"0 \u0c1f\u0c4d\u0c30\u0c3f\u0c32\u0c3f\u0c2f\u0c28\u0c4d\u0c32\u0c41"},
1E13:{other:"00 \u0c1f\u0c4d\u0c30\u0c3f\u0c32\u0c3f\u0c2f\u0c28\u0c4d\u0c32\u0c41"},1E14:{other:"000 \u0c1f\u0c4d\u0c30\u0c3f\u0c32\u0c3f\u0c2f\u0c28\u0c4d\u0c32\u0c41"}}};var d={I:"y",la:"y G",J:"MMM y",K:"MMMM y",s:"MMM d",u:"MMMM dd",w:"M/d",v:"MMMM d",V:"MMM d, y",H:"EEE, MMM d",ja:"EEE, MMM d, y",f:"d"},d={I:"y",la:"G y",J:"MMM y",K:"MMMM y",s:"d MMM",u:"dd MMMM",w:"d/M",v:"d MMMM",V:"d, MMM y",H:"EEE, d MMM",ja:"EEE, d, MMM y",f:"d"};var h;
h={R:["\u0c15\u0c4d\u0c30\u0c40\u0c2a\u0c42","\u0c15\u0c4d\u0c30\u0c40\u0c36"],P:["\u0c15\u0c4d\u0c30\u0c40\u0c38\u0c4d\u0c24\u0c41 \u0c2a\u0c42\u0c30\u0c4d\u0c35\u0c02","\u0c15\u0c4d\u0c30\u0c40\u0c38\u0c4d\u0c24\u0c41 \u0c36\u0c15\u0c02"],W:"\u0c1c \u0c2b\u0c3f \u0c2e\u0c3e \u0c0f \u0c2e\u0c47 \u0c1c\u0c42 \u0c1c\u0c41 \u0c06 \u0c38\u0c46 \u0c05 \u0c28 \u0c21\u0c3f".split(" "),ca:"\u0c1c \u0c2b\u0c3f \u0c2e\u0c3e \u0c0f \u0c2e\u0c47 \u0c1c\u0c42 \u0c1c\u0c41 \u0c06 \u0c38\u0c46 \u0c05 \u0c28 \u0c21\u0c3f".split(" "),U:"\u0c1c\u0c28\u0c35\u0c30\u0c3f \u0c2b\u0c3f\u0c2c\u0c4d\u0c30\u0c35\u0c30\u0c3f \u0c2e\u0c3e\u0c30\u0c4d\u0c1a\u0c3f \u0c0f\u0c2a\u0c4d\u0c30\u0c3f\u0c32\u0c4d \u0c2e\u0c47 \u0c1c\u0c42\u0c28\u0c4d \u0c1c\u0c41\u0c32\u0c48 \u0c06\u0c17\u0c38\u0c4d\u0c1f\u0c41 \u0c38\u0c46\u0c2a\u0c4d\u0c1f\u0c46\u0c02\u0c2c\u0c30\u0c4d \u0c05\u0c15\u0c4d\u0c1f\u0c4b\u0c2c\u0c30\u0c4d \u0c28\u0c35\u0c02\u0c2c\u0c30\u0c4d \u0c21\u0c3f\u0c38\u0c46\u0c02\u0c2c\u0c30\u0c4d".split(" "),
ba:"\u0c1c\u0c28\u0c35\u0c30\u0c3f \u0c2b\u0c3f\u0c2c\u0c4d\u0c30\u0c35\u0c30\u0c3f \u0c2e\u0c3e\u0c30\u0c4d\u0c1a\u0c3f \u0c0f\u0c2a\u0c4d\u0c30\u0c3f\u0c32\u0c4d \u0c2e\u0c47 \u0c1c\u0c42\u0c28\u0c4d \u0c1c\u0c41\u0c32\u0c48 \u0c06\u0c17\u0c38\u0c4d\u0c1f\u0c41 \u0c38\u0c46\u0c2a\u0c4d\u0c1f\u0c46\u0c02\u0c2c\u0c30\u0c4d \u0c05\u0c15\u0c4d\u0c1f\u0c4b\u0c2c\u0c30\u0c4d \u0c28\u0c35\u0c02\u0c2c\u0c30\u0c4d \u0c21\u0c3f\u0c38\u0c46\u0c02\u0c2c\u0c30\u0c4d".split(" "),Z:"\u0c1c\u0c28 \u0c2b\u0c3f\u0c2c\u0c4d\u0c30 \u0c2e\u0c3e\u0c30\u0c4d\u0c1a\u0c3f \u0c0f\u0c2a\u0c4d\u0c30\u0c3f \u0c2e\u0c47 \u0c1c\u0c42\u0c28\u0c4d \u0c1c\u0c41\u0c32\u0c48 \u0c06\u0c17 \u0c38\u0c46\u0c2a\u0c4d\u0c1f\u0c46\u0c02 \u0c05\u0c15\u0c4d\u0c1f\u0c4b \u0c28\u0c35\u0c02 \u0c21\u0c3f\u0c38\u0c46\u0c02".split(" "),
ea:"\u0c1c\u0c28 \u0c2b\u0c3f\u0c2c\u0c4d\u0c30 \u0c2e\u0c3e\u0c30\u0c4d\u0c1a\u0c3f \u0c0f\u0c2a\u0c4d\u0c30\u0c3f \u0c2e\u0c47 \u0c1c\u0c42\u0c28\u0c4d \u0c1c\u0c41\u0c32\u0c48 \u0c06\u0c17\u0c38\u0c4d\u0c1f\u0c41 \u0c38\u0c46\u0c2a\u0c4d\u0c1f\u0c46\u0c02 \u0c05\u0c15\u0c4d\u0c1f\u0c4b \u0c28\u0c35\u0c02 \u0c21\u0c3f\u0c38\u0c46\u0c02".split(" "),ia:"\u0c06\u0c26\u0c3f\u0c35\u0c3e\u0c30\u0c02 \u0c38\u0c4b\u0c2e\u0c35\u0c3e\u0c30\u0c02 \u0c2e\u0c02\u0c17\u0c33\u0c35\u0c3e\u0c30\u0c02 \u0c2c\u0c41\u0c27\u0c35\u0c3e\u0c30\u0c02 \u0c17\u0c41\u0c30\u0c41\u0c35\u0c3e\u0c30\u0c02 \u0c36\u0c41\u0c15\u0c4d\u0c30\u0c35\u0c3e\u0c30\u0c02 \u0c36\u0c28\u0c3f\u0c35\u0c3e\u0c30\u0c02".split(" "),
ga:"\u0c06\u0c26\u0c3f\u0c35\u0c3e\u0c30\u0c02 \u0c38\u0c4b\u0c2e\u0c35\u0c3e\u0c30\u0c02 \u0c2e\u0c02\u0c17\u0c33\u0c35\u0c3e\u0c30\u0c02 \u0c2c\u0c41\u0c27\u0c35\u0c3e\u0c30\u0c02 \u0c17\u0c41\u0c30\u0c41\u0c35\u0c3e\u0c30\u0c02 \u0c36\u0c41\u0c15\u0c4d\u0c30\u0c35\u0c3e\u0c30\u0c02 \u0c36\u0c28\u0c3f\u0c35\u0c3e\u0c30\u0c02".split(" "),aa:"\u0c06\u0c26\u0c3f \u0c38\u0c4b\u0c2e \u0c2e\u0c02\u0c17\u0c33 \u0c2c\u0c41\u0c27 \u0c17\u0c41\u0c30\u0c41 \u0c36\u0c41\u0c15\u0c4d\u0c30 \u0c36\u0c28\u0c3f".split(" "),
fa:"\u0c06\u0c26\u0c3f \u0c38\u0c4b\u0c2e \u0c2e\u0c02\u0c17\u0c33 \u0c2c\u0c41\u0c27 \u0c17\u0c41\u0c30\u0c41 \u0c36\u0c41\u0c15\u0c4d\u0c30 \u0c36\u0c28\u0c3f".split(" "),X:"\u0c06 \u0c38\u0c4b \u0c2e \u0c2c\u0c41 \u0c17\u0c41 \u0c36\u0c41 \u0c36".split(" "),da:"\u0c06 \u0c38\u0c4b \u0c2e \u0c2c\u0c41 \u0c17\u0c41 \u0c36\u0c41 \u0c36".split(" "),$:["\u0c24\u0c4d\u0c30\u0c481","\u0c24\u0c4d\u0c30\u0c482","\u0c24\u0c4d\u0c30\u0c483","\u0c24\u0c4d\u0c30\u0c484"],Y:["1\u0c35 \u0c24\u0c4d\u0c30\u0c48\u0c2e\u0c3e\u0c38\u0c02",
"2\u0c35 \u0c24\u0c4d\u0c30\u0c48\u0c2e\u0c3e\u0c38\u0c02","3\u0c35 \u0c24\u0c4d\u0c30\u0c48\u0c2e\u0c3e\u0c38\u0c02","4\u0c35 \u0c24\u0c4d\u0c30\u0c48\u0c2e\u0c3e\u0c38\u0c02"],M:["[AM]","[PM]"],N:["d, MMMM y, EEEE","d MMMM, y","d MMM, y","dd-MM-yy"],ha:["h:mm:ss a zzzz","h:mm:ss a z","h:mm:ss a","h:mm a"],O:["{1} {0}","{1} {0}","{1} {0}","{1} {0}"],S:6,ka:[6,6],T:5};var l={h:".",l:",",B:"%",L:"0",F:"+",o:"-",j:"E",D:"\u2030",m:"\u221e",A:"NaN",g:"#,##0.###",G:"#E0",C:"#,##0%",c:"\u00a4#,##0.00",i:"USD"},l={h:".",l:",",B:"%",L:"0",F:"+",o:"-",j:"E",D:"\u2030",m:"\u221e",A:"NaN",g:"#,##,##0.###",G:"#E0",C:"#,##0%",c:"\u00a4#,##,##0.00",i:"INR"};b("I18N_DATETIMESYMBOLS_ERAS",h.R);b("I18N_DATETIMESYMBOLS_ERANAMES",h.P);b("I18N_DATETIMESYMBOLS_NARROWMONTHS",h.W);b("I18N_DATETIMESYMBOLS_STANDALONENARROWMONTHS",h.ca);b("I18N_DATETIMESYMBOLS_MONTHS",h.U);b("I18N_DATETIMESYMBOLS_STANDALONEMONTHS",h.ba);b("I18N_DATETIMESYMBOLS_SHORTMONTHS",h.Z);b("I18N_DATETIMESYMBOLS_STANDALONESHORTMONTHS",h.ea);b("I18N_DATETIMESYMBOLS_WEEKDAYS",h.ia);b("I18N_DATETIMESYMBOLS_STANDALONEWEEKDAYS",h.ga);b("I18N_DATETIMESYMBOLS_SHORTWEEKDAYS",h.aa);
b("I18N_DATETIMESYMBOLS_STANDALONESHORTWEEKDAYS",h.fa);b("I18N_DATETIMESYMBOLS_NARROWWEEKDAYS",h.X);b("I18N_DATETIMESYMBOLS_STANDALONENARROWWEEKDAYS",h.da);b("I18N_DATETIMESYMBOLS_SHORTQUARTERS",h.$);b("I18N_DATETIMESYMBOLS_QUARTERS",h.Y);b("I18N_DATETIMESYMBOLS_AMPMS",h.M);b("I18N_DATETIMESYMBOLS_DATEFORMATS",h.N);b("I18N_DATETIMESYMBOLS_TIMEFORMATS",h.ha);b("I18N_DATETIMESYMBOLS_DATETIMEFORMATS",h.O);b("I18N_DATETIMESYMBOLS_AVAILABLEFORMATS",h.na);b("I18N_DATETIMESYMBOLS_FIRSTDAYOFWEEK",h.S);
b("I18N_DATETIMESYMBOLS_WEEKENDRANGE",h.ka);b("I18N_DATETIMESYMBOLS_FIRSTWEEKCUTOFFDAY",h.T);b("I18N_DATETIMEPATTERNS_YEAR_FULL",d.I);b("I18N_DATETIMEPATTERNS_YEAR_MONTH_ABBR",d.J);b("I18N_DATETIMEPATTERNS_YEAR_MONTH_FULL",d.K);b("I18N_DATETIMEPATTERNS_MONTH_DAY_ABBR",d.s);b("I18N_DATETIMEPATTERNS_MONTH_DAY_FULL",d.u);b("I18N_DATETIMEPATTERNS_MONTH_DAY_SHORT",d.w);b("I18N_DATETIMEPATTERNS_MONTH_DAY_MEDIUM",d.v);b("I18N_DATETIMEPATTERNS_WEEKDAY_MONTH_DAY_MEDIUM",d.H);
b("I18N_DATETIMEPATTERNS_DAY_ABBR",d.f);void 0!==h.ma&&b("I18N_DATETIMESYMBOLS_ZERODIGIT",h.ma);b("I18N_NUMBERFORMATSYMBOLS_DECIMAL_SEP",l.h);b("I18N_NUMBERFORMATSYMBOLS_GROUP_SEP",l.l);b("I18N_NUMBERFORMATSYMBOLS_PERCENT",l.B);b("I18N_NUMBERFORMATSYMBOLS_ZERO_DIGIT",l.L);b("I18N_NUMBERFORMATSYMBOLS_PLUS_SIGN",l.F);b("I18N_NUMBERFORMATSYMBOLS_MINUS_SIGN",l.o);b("I18N_NUMBERFORMATSYMBOLS_EXP_SYMBOL",l.j);b("I18N_NUMBERFORMATSYMBOLS_PERMILL",l.D);b("I18N_NUMBERFORMATSYMBOLS_INFINITY",l.m);
b("I18N_NUMBERFORMATSYMBOLS_NAN",l.A);b("I18N_NUMBERFORMATSYMBOLS_DECIMAL_PATTERN",l.g);b("I18N_NUMBERFORMATSYMBOLS_SCIENTIFIC_PATTERN",l.G);b("I18N_NUMBERFORMATSYMBOLS_PERCENT_PATTERN",l.C);b("I18N_NUMBERFORMATSYMBOLS_CURRENCY_PATTERN",l.c);b("I18N_NUMBERFORMATSYMBOLS_DEF_CURRENCY_CODE",l.i);b("I18N_COMPACT_DECIMAL_SHORT_PATTERN",c.b);b("I18N_COMPACT_DECIMAL_LONG_PATTERN",c.a);
