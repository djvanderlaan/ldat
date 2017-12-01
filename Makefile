
.PHONY: readme install test check build document load_all

all: document readme build

readme: README.md

README.md: README.Rmd
	R  --vanilla --slave -e "library(knitr); knit('README.Rmd')"

document:
	R --vanilla --slave -e "devtools::document()"

load_all: 
	R --vanilla --slave -e "devtools::load_all()"

install:
	R --vanilla --slave -e "devtools::install()"

test: load_all
	R --vanilla --slave -e "devtools::test()"

check:
	R --vanilla --slave -e "devtools::check()"

build: 
	R --vanilla --slave -e "devtools::build()"

