cas casauto sessopts=(caslib="casuser");

proc format library=work.formats casfmtlib="workshopformats";               /* 1 */
  value enginesize 
    low - <2.7 = "Very economical"
    2.7 - <4.1 = "Small"
    4.1 - <5.5 = "Medium"
    5.5 - <6.9 = "Large"
    6.9 - high = "Very large"
;

cas casauto savefmtlib fmtlibname=workshopformats                           /* 2 */
   table=enginefmt replace;
cas casauto promotefmtlib fmtlibname=workshopformats replace; 
proc casutil;
droptable casdata="cars" incaslib="casuser"; 
  format enginesize enginesize.;                                       /* 3 */
  load data=sashelp.cars casout="cars" promote ;
  contents casdata="cars";
quit;

libname mycas cas;                                                     /* 4 */

proc mdsummary data=mycas.cars;
  var mpg_highway;
  groupby enginesize / out=mycas.mpg_hwy_by_size;                      /* 5 */
run;

proc print data=mycas.mpg_hwy_by_size;
  var enginesize--_mean_;
run;

/* 
 * run the following CASUTIL code if you plan 
 * to run the next example that adds a format
 * library from a file.
 */
proc casutil;
  save casdata="cars" casout="cars_formatted" replace;
  *droptable casdata="cars"  ;
quit;