**installation
ssc install metan 
ssc install metabias 
ssc install metatrim
ssc install metaninf
ssc install heterogi
ssc install galbr

gen lnor=ln(or)
gen lnlci=ln(lci)
gen lnuci=ln(uci) 
gen selnci=(lnuci-lnlci)/3.92

**meta set
meta set or selnci, random(dlaird) studylabel(studyid) eslabel(OR)
meta set or selnci, fixed(mhaenszel) studylabel(studyid) eslabel(OR)

**meta summarize
meta summarize, random(dlaird) 

**forest plot
meta forestplot, random(dlaird) eform(OR) hruleopts(lcolor(black) lpattern(solid)) esrefline(lcolor(red) lpattern(dash))
meta forestplot, fixed(mhaenszel) eform(OR) hruleopts(lcolor(black) lpattern(solid)) esrefline(lcolor(red) lpattern(dash))

**publication bias 
meta bias, egger random(dlaird) tdistribution detail
meta bias, egger fixed tdistribution detail

**subgroup analysis
meta forestplot, random(dlaird) subgroup(design) esrefline(lcolor(cranberry) lpattern(dash)) xline(1, lpattern(solid) lcolor(black))

**sensitive analysis
preserve
drop if bias=="high" | "unclear"
meta forestplot, random(dlaird) eform(OR) hruleopts(lcolor(black) lpattern(solid)) esrefline(lcolor(red) lpattern(dash))
restore

preserve
drop if bias=="high" | "unclear"
meta forestplot, fixed(mhaenszel) eform(OR) hruleopts(lcolor(black) lpattern(solid)) esrefline(lcolor(red) lpattern(dash))
restore
