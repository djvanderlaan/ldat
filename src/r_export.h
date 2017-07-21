#include <lvec_interface.h>

extern "C" {
  SEXP lmatch(SEXP rv, SEXP rvo, SEXP rtab, SEXP rtabo, SEXP rna_incomp);
  SEXP partial_order(SEXP rv, SEXP rpivots);
  SEXP partial_sort(SEXP rv, SEXP rpivots);
  SEXP order_ldat(SEXP rveclist);
}
