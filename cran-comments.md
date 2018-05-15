

The new version of `lvec` on which `ldat` depends now uses `Rcpp`. This breaks
`ldat`. This update works with the new version (0.2) of `lvec` but doesn't 
work with the current version of `lvec` (0.1.1). I will upload both packages at
the same time. In the Description file of `ldat` I have added a minimal version
number for `lvec` (>= 0.2.0). 

The CRAN checks on https://cran.r-project.org/web/checks/check_results_ldat.html
show two notes and an error on Solaris. The notes should be fixed and the error
should also be fixed, but without a Solaris system to test on this is a bit of a
shot in the dark. 


## Test environments
* local ubuntu 17.10 install, R 3.4.4
* local ubuntu 17.10 install, R 3.4.4; with valgrind
* R-devel on windows using the R-builder

I had problems testing the package on other platforms as R 3.5 is not yet 
released for Ubuntu and the package depends on a package (lvec >= 0.2) that
is not yet on CRAN so I could also not test using rhub. 

## R CMD check results

0 errors | 0 warnings | 0 notes


## Reverse dependencies

None

