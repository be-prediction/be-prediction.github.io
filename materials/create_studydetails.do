clear
cd "${STATAPATH}"

set obs 18
gen int study= _n

label define study 1 "Abeler et al. (AER 2011)" ///
2 "Ambrus and Greiner (AER 2012)" ///
3 "Bartling et al. (AER 2012)" ///
4 "Charness and Dufwenberg (AER 2011)" ///
5 "Chen and Chen (AER 2011)" ///
6 "de Clippel et al. (AER 2014)" ///
7 "Duffy and Puzzello (AER 2014)" ///
8 "Dulleck et al. (AER 2011)" ///
9 "Fehr et al. (AER 2013)" ///
10 "Friedman and Oprea (AER 2012)" ///
11 "Fudenberg et al. (AER 2012)" ///
12 "Huck et al. (AER 2011)" ///
13 "Ifcher and Zarghamee (AER 2011)" ///
14 "Kessler and Roth (AER 2012)" ///
15 "Kirchler et al (AER 2012)" ///
16 "Kogan et al. (AER 2011)" ///
17 "Kuziemko et al. (QJE 2014)" ///
18 "Ericson and Fuster (QJE 2011)"

label values study study

// Ericson and Fuster (QJE 2011) was misnamed as Marzilli Eric...
// on the markets, correct order:
gen sortorder = study
replace sortorder = 8.5 if study==18
sort sortorder
drop sortorder

gen ref = .
label var ref "Reference number in paper"
replace ref = _n + 32

gen pubdate = .
format pubdate %td
label var pubdate "Date of publication"

gen collectdate = mdy(11,27,2015)
format collectdate %td
label var collectdate "Time of citation count collections"

gen citations = .
label var citations "Paper citation count at collection date" 

gen porig = .
label var porig "P-value of original study"

gen prep = .
label var prep "P-value of replication"

gen int result = .
label var result "Replication result (prep<0.05)"

gen int norig = .
label var norig "Subjects in original study"

gen int nrep_plan = .
label var nrep_plan "Planned subjects in replication"

gen int nrep_act = .
label var nrep_act "Actual subjects in replication"

gen powrep_plan = .
label var powrep_plan "Planned power of replication"

gen powrep_act = .
label var powrep_act "Actual power of replication"

gen poworig = .
label var poworig "Power of original study (post hoc)"

gen erel_ns = . 
label var erel_ns "Non-standardized normalized effect size of replication study"




// Study 1
replace pubdate = mdy(4,1,2011) if study==1
replace citations = 311 if study==1

replace porig = 0.046 if study==1
replace norig = 120 if study==1
replace poworig = . if study==1

replace nrep_plan = 318 if study==1
replace nrep_act = nrep_plan if study==1
replace powrep_plan = 0.9 if study==1
replace powrep_act = powrep_plan if study==1

replace prep = .16 if study==1
replace erel_ns = 0.667/1.850 if study==1
replace result = 0 if study==1

// Study 2
replace pubdate = mdy(12,1,2012) if study==2
replace citations = 58 if study==2

replace porig = 0.057 if study==2
replace norig = 117 if study==2
replace poworig = . if study==2

replace nrep_plan = 340 if study==2
replace nrep_act = 357 if study==2
replace powrep_plan = 0.9 if study==2
replace powrep_act = 0.91 if study==2

replace prep = 0.012 if study==2
replace erel_ns = (-2.021/-2.914) if study==2
replace result = 1 if study==2

// Study 3
replace pubdate = mdy(4,1,2012) if study==3
replace citations = 72 if study==3

replace porig = 0.007 if study==3
replace norig = 216 if study==3
replace poworig = . if study==3

replace nrep_plan = 360 if study==3
replace nrep_act = nrep_plan if study==3
replace powrep_plan = 0.94 if study==3
replace powrep_act = powrep_plan if study==3

replace prep = 0.001 if study==3
replace erel_ns = (7.16/5.92) if study==3
replace result = 1 if study==3

// Study 4
replace pubdate = mdy(6,1,2011) if study==4
replace citations = 63 if study==4

replace porig = 0.01 if study==4
replace norig = 162 if study==4
replace poworig = . if study==4

replace nrep_plan = 264 if study==4
replace nrep_act = nrep_plan if study==4
replace powrep_plan = 0.9 if study==4
replace powrep_act = powrep_plan if study==4

replace prep = 0.003 if study==4
replace erel_ns = (35.73/38.26) if study==4
replace result = 1 if study==4

// Study 5
replace pubdate = mdy(10,1,2011) if study==5
replace citations = 114 if study==5

replace porig = 0.033 if study==5
replace norig = 72 if study==5
replace poworig = . if study==5

replace nrep_plan = 168 if study==5
replace nrep_act = nrep_plan if study==5
replace powrep_plan = 0.9 if study==5
replace powrep_act = powrep_plan if study==5

replace prep = 0.571 if study==5
replace erel_ns = (5.204/23.852) if study==5
replace result = 0 if study==5

// Study 6
replace pubdate = mdy(11,1,2014) if study==6
replace citations = 7 if study==6

replace porig = 0.001 if study==6
replace norig = 158 if study==6
replace poworig = . if study==6

replace nrep_plan = 156 if study==6
replace nrep_act = nrep_plan if study==6
replace powrep_plan = 0.9 if study==6
replace powrep_act = powrep_plan if study==6

replace prep = 4*10^(-10) if study==6 // Approximate, rather (1-t(7.7135, 778))*2
replace erel_ns = (0.167/0.052) if study==6
replace result = 1 if study==6

// Study 7
replace pubdate = mdy(6,1,2014) if study==7
replace citations = 8 if study==7

replace porig = 0.01 if study==7
replace norig = 54 if study==7
replace poworig = . if study==7

replace nrep_plan = 96 if study==7
replace nrep_act = nrep_plan if study==7
replace powrep_plan = 0.93 if study==7
replace powrep_act = powrep_plan if study==7

replace prep = 0.674 if study==7 // Effect in opposite direction
replace erel_ns = (-0.03/0.16) if study==7
replace result = 0 if study==7

// Study 8
replace pubdate = mdy(4,1,2011) if study==8
replace citations = 115 if study==8

replace porig = 0.0001 if study==8
replace norig = 168 if study==8
replace poworig = . if study==8

replace nrep_plan = 128 if study==8
replace nrep_act = nrep_plan if study==8
replace powrep_plan = 0.92 if study==8
replace powrep_act = powrep_plan if study==8

replace prep = 0.0008 if study==8
replace erel_ns = (0.61/0.65) if study==8
replace result = 1 if study==8

// Study 9
replace pubdate = mdy(6,1,2013) if study==9
replace citations = 82 if study==9

replace porig = 0.011 if study==9
replace norig = 60 if study==9
replace poworig = . if study==9

replace nrep_plan = 102 if study==9
replace nrep_act = nrep_plan if study==9
replace powrep_plan = 0.91 if study==9
replace powrep_act = powrep_plan if study==9

replace prep = 0.026 if study==9
replace erel_ns = (0.219/0.262) if study==9
replace result = 1 if study==9

// Study 10
replace pubdate = mdy(2,1,2012) if study==10
replace citations = 52 if study==10

replace porig = 4*10^(-11) if study==10
replace norig = 78 if study==10
replace poworig = . if study==10

replace nrep_plan = 40 if study==10
replace nrep_act = nrep_plan if study==10
replace powrep_plan = 0.99 if study==10
replace powrep_act = powrep_plan if study==10

replace prep = 0.004276 if study==10
replace erel_ns = (0.504/0.743) if study==10
replace result = 1 if study==10

// Study 11
replace pubdate = mdy(4,1,2012) if study==11
replace citations = 122 if study==11

replace porig = 0.001 if study==11
replace norig = 124 if study==11
replace poworig = . if study==11

replace nrep_plan = 120 if study==11
replace nrep_act = 128 if study==11
replace powrep_plan = 0.9 if study==11
replace powrep_act = 0.92 if study==11

replace prep = 2*(1-normal(abs(-3.79))) if study==11
replace erel_ns = (-0.605/-0.627) if study==11
replace result = 1 if study==11

// Study 12
replace pubdate = mdy(4,1,2011) if study==12
replace citations = 14 if study==12

replace porig = 0.0039 if study==12
replace norig = 120 if study==12
replace poworig = . if study==12

replace nrep_plan = 160 if study==12
replace nrep_act = nrep_plan if study==12
replace powrep_plan = 0.91 if study==12
replace powrep_act = powrep_plan if study==12

replace prep = 0.1415 if study==12
replace erel_ns = (14.23/33.43) if study==12
replace result = 0 if study==12

// Study 13
replace pubdate = mdy(12,1,2011) if study==13
replace citations = 91 if study==13

replace porig = 0.031 if study==13
replace norig = 58 if study==13
replace poworig = . if study==13

replace nrep_plan = 131 if study==13
replace nrep_act = nrep_plan if study==13
replace powrep_plan = 0.9 if study==13
replace powrep_act = powrep_plan if study==13

replace prep = 0.933 if study==13
replace erel_ns = (-0.057/2.997) if study==13
replace result = 0 if study==13

// Study 14
replace pubdate = mdy(8,1,2012) if study==14
replace citations = 37 if study==14

replace porig = 1.631*10^(-18) if study==14
replace norig = 288 if study==14
replace poworig = . if study==14

replace nrep_plan = 48 if study==14
replace nrep_act = nrep_plan if study==14
replace powrep_plan = 0.95 if study==14
replace powrep_act = powrep_plan if study==14

replace prep = 0.016 if study==14
replace erel_ns = (0.239/0.383) if study==14
replace result = 1 if study==14

// Study 15
replace pubdate = mdy(4,1,2012) if study==15
replace citations = 102 if study==15

replace porig = 0.0163 if study==15
replace norig = 120 if study==15
replace poworig = . if study==15

replace nrep_plan = 220 if study==15
replace nrep_act = nrep_plan if study==15
replace powrep_plan = 0.9 if study==15
replace powrep_act = powrep_plan if study==15

replace prep = 0.0095 if study==15
replace erel_ns = (0.108/0.355) if study==15
replace result = 1 if study==15

// Study 16
replace pubdate = mdy(4,1,2011) if study==16
replace citations = 20 if study==16

replace porig = 0.000026 if study==16
replace norig = 126 if study==16
replace poworig = . if study==16

replace nrep_plan = 90 if study==16
replace nrep_act = nrep_plan if study==16
replace powrep_plan = 0.94 if study==16
replace powrep_act = powrep_plan if study==16

replace prep = 0.001 if study==16
replace erel_ns = (-2.534/-2.739) if study==16
replace result = 1 if study==16

// Study 17
replace pubdate = mdy(11,1,2013) if study==17
replace citations = 48 if study==17

replace porig = 0.07 if study==17
replace norig = 42 if study==17
replace poworig = . if study==17

replace nrep_plan = 138 if study==17
replace nrep_act = 144 if study==17
replace powrep_plan = 0.91 if study==17
replace powrep_act = 0.92 if study==17

replace prep = 0.154 if study==17
replace erel_ns = (0.045/ -0.116) if study==17
replace result = 0 if study==17

// Study 18
replace pubdate = mdy(10,1,2011) if study==18
replace citations = 129 if study==18

replace porig = 0.03 if study==18
replace norig = 112 if study==18
replace poworig = . if study==18

replace nrep_plan = 250 if study==18
replace nrep_act = 262 if study==18
replace powrep_plan = 0.9 if study==18
replace powrep_act = 0.91 if study==18

replace prep = 0.0546 if study==18
replace erel_ns = (0.22/0.32) if study==18
replace result = 0 if study==18


// Citations per month
gen citationspermonth = citations/(mofd(collectdate)-mofd(pubdate))
label var citationspermonth "Citations per month since publication"


*********************************
*** Standardized effect sizes ***
*********************************
gen eorig = .
label var eorig "Effect size of original study"
gen eorigl95 = .
label var eorigl95 "Lower bound of 95% interval around original effect size (r)"
gen eorigu95 = .
label var eorigu95 "Upper bound of 95% interval around original effect size (r)"
gen eorigl90 = .
label var eorigl90 "Lower bound of 90% interval around original effect size (r)"
gen eorigu90 = .
label var eorigu90 "Upper bound of 90% interval around original effect size (r)"
gen e33orig = .
label var e33orig "Effect size (r) that the original study had 33% power to detect"
gen eorigpredl95 = .
label var eorigpredl95 "Lower bound of 95% prediction interval around original effect size (3)"
gen eorigpredu95 = .
label var eorigpredu95 "Upper bound of 95% prediction interval around original effect size (3)"
gen erep = .
label var erep "Effect size of replication study"
gen erepl95 = .
label var erepl95 "Lower bound of 95% interval around replication effect size (r)"
gen erepu95 = .
label var erepu95 "Upper bound of 95% interval around replication effect size (r)"
gen erepl90 = .
label var erepl90 "Lower bound of 90% interval around replication effect size (r)"
gen erepu90 = .
label var erepu90 "Upper bound of 90% interval around replication effect size (r)"
gen emeta = .
label var emeta "Effect size of meta study"
gen emetal95 = .
label var emetal95 "Lower bound of 95% interval around meta effect size (r)"
gen emetau95 = .
label var emetau95 "Upper bound of 95% interval around meta effect size (r)"
gen emetal90 = .
label var emetal90 "Lower bound of 90% interval around meta effect size (r)"
gen emetau90 = .
label var emetau90 "Upper bound of 90% interval around meta effect size (r)"

// Study 1
replace eorig = 0.182821975588 if study==1
replace eorigl90 = 0.0328221323456 if study==1
replace eorigu90 = 0.324767394327 if study==1
replace eorigl95 = 0.00370194653852 if study==1
replace eorigu95 = 0.350575225459 if study==1
replace e33orig = 0.139907836986 if study==1
replace eorigpredl95 = -0.0272907536259 if study==1
replace eorigpredu95 = 0.377463960166 if study==1

replace erep = 0.0790703532018 if study==1
replace erepl90 = -0.0134404334126 if study==1
replace erepu90 = 0.17023897691 if study==1
replace erepl95 = -0.0311855844589 if study==1
replace erepu95 = 0.187425135837 if study==1

replace emeta = 0.107437088259 if study==1
replace emetal90 = 0.0287074003116 if study==1
replace emetau90 = 0.184842027426 if study==1
replace emetal95 = 0.0135537060865 if study==1
replace emetau95 = 0.199442755623 if study==1

// Study 2
replace eorig = 0.310518647505 if study==2
replace eorigl90 = 0.0469425024048 if study==2
replace eorigu90 = 0.533669229543 if study==2
replace eorigl95 = -0.00554130733746 if study==2
replace eorigu95 = 0.570173555797 if study==2
replace e33orig = 0.246879577687 if study==2
replace eorigpredl95 = -0.0527610839878 if study==2
replace eorigpredu95 = 0.601215599148 if study==2

replace erep = 0.229536356959 if study==2
replace erepl90 = 0.0808026096829 if study==2
replace erepu90 = 0.368270542544 if study==2
replace erepl95 = 0.0516758226292 if study==2
replace erepu95 = 0.393283203897 if study==2

replace emeta = 0.249054523453 if study==2
replace emetal90 = 0.120402383561 if study==2
replace emetau90 = 0.369479179177 if study==2
replace emetal95 = 0.0951418429508 if study==2
replace emetau95 = 0.391337665564 if study==2

// Study 3
replace eorig = 0.719849875686 if study==3
replace eorigl90 = 0.344375908359 if study==3
replace eorigu90 = 0.896798147173 if study==3
replace eorigl95 = 0.248686284485 if study==3
replace eorigu95 = 0.915526451471 if study==3
replace e33orig = 0.455749511728 if study==3
replace eorigpredl95 = 0.0990490082383 if study==3
replace eorigpredu95 = 0.937293596276 if study==3

replace erep = 0.657411288278 if study==3
replace erepl90 = 0.370761073921 if study==3
replace erepu90 = 0.82970109954 if study==3
replace erepl95 = 0.303054588684 if study==3
replace erepu95 = 0.852054070239 if study==3

replace emeta = 0.680188699839 if study==3
replace emetal90 = 0.467512864836 if study==3
replace emetau90 = 0.818431223085 if study==3
replace emetal95 = 0.417850147343 if study==3
replace emetau95 = 0.837829364696 if study==3

// Study 4
replace eorig = 0.383943377571 if study==4
replace eorigl90 = 0.14360296396 if study==4
replace eorigu90 = 0.58151640702 if study==4
replace eorigl95 = 0.0944963689171 if study==4
replace eorigu95 = 0.613537176605 if study==4
replace e33orig = 0.234916687065 if study==4
replace eorigpredl95 = 0.00719009094293 if study==4
replace eorigpredu95 = 0.665244342552 if study==4

replace erep = 0.363002684809 if study==4
replace erepl90 = 0.169783142539 if study==4
replace erepu90 = 0.529346339936 if study==4
replace erepl95 = 0.130672828091 if study==4
replace erepu95 = 0.557539463481 if study==4

replace emeta = 0.371260032182 if study==4
replace emetal90 = 0.223197752355 if study==4
replace emetau90 = 0.50257736448 if study==4
replace emetal95 = 0.193353354423 if study==4
replace emetau95 = 0.525529814991 if study==4

// Study 5
replace eorig = 0.842508557739 if study==5
replace eorigl90 = 0.272997064925 if study==5
replace eorigu90 = 0.9747363985 if study==5
replace eorigl95 = 0.0978561808619 if study==5
replace eorigu95 = 0.982374145079 if study==5
replace e33orig = 0.672241210903 if study==5
replace eorigpredl95 = -0.0468105691004 if study==5
replace eorigpredu95 = 0.986782287784 if study==5

replace erep = 0.170189166838 if study==5
replace erepl90 = -0.313191913476 if study==5
replace erepu90 = 0.583533168602 if study==5
replace erepl95 = -0.39616345317 if study==5
replace erepu95 = 0.64273079609 if study==5

replace emeta = 0.378710316548 if study==5
replace emetal90 = -0.0410294087807 if study==5
replace emetau90 = 0.684832604667 if study==5
replace emetal95 = -0.124618070151 if study==5
replace emetau95 = 0.727019299106 if study==5

// Study 6
replace eorig = 0.117768981826 if study==6
replace eorigl90 = 0.0596145531844 if study==6
replace eorigu90 = 0.175126698779 if study==6
replace eorigl95 = 0.0484149726004 if study==6
replace eorigu95 = 0.185992845393 if study==6
replace e33orig = 0.0544052124915 if study==6
replace eorigpredl95 = 0.0191940021317 if study==6
replace eorigpredu95 = 0.214076431131 if study==6

replace erep = 0.266538269195 if study==6
replace erepl90 = 0.210911257969 if study==6
replace erepu90 = 0.320444526763 if study==6
replace erepl95 = 0.200084249083 if study==6
replace erepu95 = 0.330551204901 if study==6

replace emeta = 0.192787720229 if study==6
replace emetal90 = 0.152441408389 if study==6
replace emetau90 = 0.232492519327 if study==6
replace emetal95 = 0.144649362182 if study==6
replace emetau95 = 0.24001564406 if study==6

// Study 7
replace eorig = 0.761510174904 if study==7
replace eorigl90 = 0.316984673143 if study==7
replace eorigu90 = 0.931724504855 if study==7
replace eorigl95 = 0.197037122338 if study==7
replace eorigu95 = 0.946801042792 if study==7
replace e33orig = 0.533325195306 if study==7
replace eorigpredl95 = 0.03245213037 if study==7
replace eorigpredu95 = 0.961630679616 if study==7

replace erep = -0.11596300548 if study==7
replace erepl90 = -0.517330150897 if study==7
replace erepu90 = 0.327221393339 if study==7
replace erepl95 = -0.578418809317 if study==7
replace erepu95 = 0.402902565882 if study==7

replace emeta = 0.231737391391 if study==7
replace emetal90 = -0.14039708833 if study==7
replace emetau90 = 0.546501975435 if study==7
replace emetal95 = -0.210430643113 if study==7
replace emetau95 = 0.59519393732 if study==7

// Study 8
replace eorig = 0.722509234548 if study==8
replace eorigl90 = 0.481687383086 if study==8
replace eorigu90 = 0.861869971391 if study==8
replace eorigl95 = 0.422644203566 if study==8
replace eorigu95 = 0.879791181565 if study==8
replace e33orig = 0.339256286653 if study==8
replace eorigpredl95 = 0.196889679422 if study==8
replace eorigpredu95 = 0.925526400522 if study==8

replace erep = 0.731605727911 if study==8
replace erepl90 = 0.443013025107 if study==8
replace erepu90 = 0.882812638647 if study==8
replace erepl95 = 0.370133234857 if study==8
replace erepu95 = 0.900672423325 if study==8

replace emeta = 0.726354985371 if study==8
replace emetal90 = 0.554975923357 if study==8
replace emetau90 = 0.83858675701 if study==8
replace emetal95 = 0.514586255668 if study==8
replace emetau95 = 0.854605381498 if study==8

// Study 9
replace eorig = 0.453281944406 if study==9
replace eorigl90 = 0.170586810636 if study==9
replace eorigu90 = 0.667031229166 if study==9
replace eorigl95 = 0.111166624409 if study==9
replace eorigu95 = 0.699345564948 if study==9
replace e33orig = 0.282279968305 if study==9
replace eorigpredl95 = 0.0173274376059 if study==9
replace eorigpredu95 = 0.744418358991 if study==9

replace erep = 0.311199311719 if study==9
replace erepl90 = 0.0842583537452 if study==9
replace erepu90 = 0.507448184614 if study==9
replace erepl95 = 0.0389566165029 if study==9
replace erepu95 = 0.540434534192 if study==9

replace emeta = 0.36442135939 if study==9
replace emetal90 = 0.189717014045 if study==9
replace emetau90 = 0.516757879809 if study==9
replace emetal95 = 0.154412694777 if study==9
replace emetau95 = 0.542923736386 if study==9

// Study 10
replace eorig = 0.642590125822 if study==10
replace eorigl90 = 0.517296828787 if study==10
replace eorigu90 = 0.740914806202 if study==10
replace eorigl95 = 0.490148706897 if study==10
replace eorigu95 = 0.756888765576 if study==10
replace e33orig = 0.173797607487 if study==10
replace eorigpredl95 = 0.352957942802 if study==10
replace eorigpredu95 = 0.819839510335 if study==10

replace erep = 0.437953607707 if study==10
replace erepl90 = 0.196686799056 if study==10
replace erepu90 = 0.629210535523 if study==10
replace erepl95 = 0.14641982379 if study==10
replace erepu95 = 0.659490835731 if study==10

replace emeta = 0.582222967619 if study==10
replace emetal90 = 0.470252940424 if study==10
replace emetau90 = 0.675745935357 if study==10
replace emetal95 = 0.446739940774 if study==10
replace emetau95 = 0.69160107396 if study==10

// Study 11
replace eorig = 0.303741608956 if study==11
replace eorigl90 = 0.162646793749 if study==11
replace eorigu90 = 0.432663112699 if study==11
replace eorigl95 = 0.134635358447 if study==11
replace eorigu95 = 0.455655714035 if study==11
replace e33orig = 0.137622833324 if study==11
replace eorigpredl95 = 0.0635919098039 if study==11
replace eorigpredu95 = 0.510639819163 if study==11

replace erep = 0.326573539422 if study==11
replace erepl90 = 0.189547461878 if study==11
replace erepu90 = 0.451122015097 if study==11
replace erepl95 = 0.162237079595 if study==11
replace erepu95 = 0.473282886118 if study==11

replace emeta = 0.315388803956 if study==11
replace emetal90 = 0.218086534399 if study==11
replace emetau90 = 0.40648253218 if study==11
replace emetal95 = 0.198869767468 if study==11
replace emetau95 = 0.423115614948 if study==11

// Study 12
replace eorig = 0.832065702534 if study==12
replace eorigl90 = 0.569328508809 if study==12
replace eorigu90 = 0.940584864142 if study==12
replace eorigl95 = 0.49411650002 if study==12
replace eorigu95 = 0.951569964509 if study==12
replace e33orig = 0.455749511728 if study==12
replace eorigpredl95 = 0.331859014173 if study==12
replace eorigpredu95 = 0.96705396689 if study==12

replace erep = 0.367593525514 if study==12
replace erepl90 = -0.0704456455184 if study==12
replace erepu90 = 0.686781416975 if study==12
replace erepl95 = -0.156657660899 if study==12
replace erepu95 = 0.730236559047 if study==12

replace emeta = 0.614838737319 if study==12
replace emetal90 = 0.350470609291 if study==12
replace emetau90 = 0.788460023195 if study==12
replace emetal95 = 0.290212606617 if study==12
replace emetau95 = 0.812563910878 if study==12

// Study 13
replace eorig = 0.282103220856 if study==13
replace eorigl90 = 0.0680682387744 if study==13
replace eorigu90 = 0.471313577258 if study==13
replace eorigl95 = 0.0256785402943 if study==13
replace eorigu95 = 0.503696603733 if study==13
replace e33orig = 0.201850891173 if study==13
replace eorigpredl95 = -0.0260286060229 if study==13
replace eorigpredu95 = 0.541281117546 if study==13

replace erep = -0.00701629144787 if study==13
replace erepl90 = -0.151233238817 if study==13
replace erepu90 = 0.137493119254 if study==13
replace erepl95 = -0.178327174335 if study==13
replace erepu95 = 0.164707424269 if study==13

replace emeta = 0.0820555925947 if study==13
replace emetal90 = -0.0393302768252 if study==13
replace emetau90 = 0.201054834971 if study==13
replace emetal95 = -0.0625623868116 if study==13
replace emetau95 = 0.223298666039 if study==13

// Study 14
replace eorig = 0.486223364603 if study==14
replace eorigl90 = 0.408383594253 if study==14
replace eorigu90 = 0.557042747679 if study==14
replace eorigl95 = 0.392713421968 if study==14
replace eorigu95 = 0.569782483622 if study==14
replace e33orig = 0.0901718140468 if study==14
replace eorigpredl95 = 0.213377133478 if study==14
replace eorigpredu95 = 0.688710195628 if study==14

replace erep = 0.34463841128 if study==14
replace erepl90 = 0.113653161105 if study==14
replace erepu90 = 0.540277169028 if study==14
replace erepl95 = 0.0670716160657 if study==14
replace erepu95 = 0.572692885361 if study==14

replace emeta = 0.468136543498 if study==14
replace emetal90 = 0.394514081524 if study==14
replace emetau90 = 0.535787040304 if study==14
replace emetal95 = 0.379768189627 if study==14
replace emetau95 = 0.548038650358 if study==14

// Study 15
replace eorig = 0.664409308738 if study==15
replace eorigl90 = 0.247156584767 if study==15
replace eorigu90 = 0.873805513808 if study==15
replace eorigl95 = 0.146288197065 if study==15
replace eorigu95 = 0.896478626228 if study==15
replace e33orig = 0.455749511728 if study==15
replace eorigpredl95 = 0.007564510622 if study==15
replace eorigpredu95 = 0.92072516592 if study==15

replace erep = 0.533556821497 if study==15
replace erepl90 = 0.214371652574 if study==15
replace erepu90 = 0.74978319994 if study==15
replace erepl95 = 0.144440581359 if study==15
replace erepu95 = 0.779757263449 if study==15

replace emeta = 0.579146829603 if study==15
replace emetal90 = 0.336668064522 if study==15
replace emetau90 = 0.749593295707 if study==15
replace emetal95 = 0.282852214832 if study==15
replace emetau95 = 0.7745397981 if study==15

// Study 16
replace eorig = 0.323896842962 if study==16
replace eorigl90 = 0.201908115767 if study==16
replace eorigu90 = 0.435989422561 if study==16
replace eorigl95 = 0.177666819618 if study==16
replace eorigu95 = 0.456132456597 if study==16
replace e33orig = 0.121082305984 if study==16
replace eorigpredl95 = 0.0913813442428 if study==16
replace eorigpredu95 = 0.522921346265 if study==16

replace erep = 0.304223231247 if study==16
replace erepl90 = 0.155350472452 if study==16
replace erepu90 = 0.43958430419 if study==16
replace erepl95 = 0.125767053645 if study==16
replace erepu95 = 0.463608151341 if study==16

replace emeta = 0.315867768513 if study==16
replace emetal90 = 0.222417275305 if study==16
replace emetau90 = 0.403567034039 if study==16
replace emetal95 = 0.203975447297 if study==16
replace emetau95 = 0.419613888153 if study==16

// Study 17
replace eorig = 0.282261740933 if study==17
replace eorigl90 = 0.0267441573661 if study==17
replace eorigu90 = 0.503157675785 if study==17
replace eorigl95 = -0.0237030628806 if study==17
replace eorigu95 = 0.539877947143 if study==17
replace e33orig = 0.237747192435 if study==17
replace eorigpredl95 = -0.0643760006837 if study==17
replace eorigpredu95 = 0.568118981736 if study==17

replace erep = -0.119848901099 if study==17
replace erepl90 = -0.253312598322 if study==17
replace erepu90 = 0.0180919651316 if study==17
replace erepl95 = -0.277975289639 if study==17
replace erepu95 = 0.0446014084372 if study==17

replace emeta = -0.031461450402 if study==17
replace emetal90 = -0.152864324161 if study==17
replace emetau90 = 0.0908768944909 if study==17
replace emetal95 = -0.175716185201 if study==17
replace emetau95 = 0.114115989342 if study==17

// Study 18
replace eorig = 0.212921823047 if study==18
replace eorigl90 = 0.0525125372788 if study==18
replace eorigu90 = 0.362619745072 if study==18
replace eorigl95 = 0.0212030554828 if study==18
replace eorigu95 = 0.389536617642 if study==18
replace e33orig = 0.150352478097 if study==18
replace eorigpredl95 = -0.0155309085093 if study==18
replace eorigpredu95 = 0.42024705926 if study==18

replace erep = 0.122871403263 if study==18
replace erepl90 = 0.0184074881441 if study==18
replace erepu90 = 0.224681657977 if study==18
replace erepl95 = -0.00172209297848 if study==18
replace erepu95 = 0.243708404348 if study==18

replace emeta = 0.149437772566 if study==18
replace emetal90 = 0.062057589114 if study==18
replace emetau90 = 0.234544555519 if study==18
replace emetal95 = 0.0451662496242 if study==18
replace emetau95 = 0.250488206514 if study==18


gen ereprel=erep/eorig
gen ereprell95=erepl95/eorig
gen ereprelu95=erepu95/eorig
label var ereprel "Normalized effect size of replication study"
label var ereprell95 "Lower bound of 95% interval around normalized replication effect"
label var ereprelu95 "Upper bound of 95% interval around normalized replication effect"

gen emetarel=emeta/eorig
gen emetarell95=emetal95/eorig
gen emetarelu95=emetau95/eorig
label var emetarel "Normalized effect size of meta study"
label var emetarell95 "Lower bound of 95% interval around normalized meta effect"
label var emetarelu95 "Upper bound of 95% interval around normalized meta effect"

// Save
save "../use/studydetails.dta", replace
