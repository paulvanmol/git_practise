proc means data=sashelp.class;
class sex; 
var height; 
title "statistic for height and gender Female"; 
where sex="F"; 
run;