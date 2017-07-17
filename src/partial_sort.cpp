#include <lvec_interface.h>
#include <algorithm>
#include <cstring>
#include <vector>
#include <iostream>
#include <iomanip>
#include "r_export.h"

class psort_visitor : public ldat::lvec_visitor {
  public:
    psort_visitor(std::vector<ldat::vec::vecsize> pivots) : pivots_(pivots) {
      // check pivots
      if (pivots_.size() == 0)
        throw std::runtime_error("No pivots given");
      std::sort(pivots_.begin(), pivots_.end(), std::greater<ldat::vec::vecsize>());
    }

    template<class T>
    class compare {
      public:
        bool operator()(const T& lhs, const T& rhs) {
          if (cppr::is_nan(lhs)) return false;
          if (cppr::is_nan(rhs)) return true;
          return lhs < rhs;
        }
    };

    template<typename T>
    void visit_template(ldat::lvec<T>& vec) {
      ldat::lvec_iterator<T> p = vec.end();
      for (auto piv = pivots_.begin(); piv != pivots_.end(); ++piv) {
        if (((*piv) >= vec.size()) || ((*piv) < 0)) 
          std::runtime_error("Pivots out of range.");
        ldat::lvec_iterator<T> q = vec.begin() + (*piv);
        std::nth_element(vec.begin(), q, p, compare<T>());
        p = vec.begin() + (*piv);
      }
    }

    void visit(ldat::lvec<double>& vec) {
      return visit_template(vec);
    }

    void visit(ldat::lvec<int>& vec) {
      return visit_template(vec);
    }

    void visit(ldat::lvec<cppr::boolean>& vec) {
      return visit_template(vec);
    }

    void visit(ldat::lvec<std::string>& vec) {
      return visit_template(vec);
    }

  private:
    std::vector<ldat::vec::vecsize> pivots_;
};

extern "C" {
  SEXP partial_sort(SEXP rv, SEXP rpivots) {
    CPPRTRY
    ldat::vec* v = sexp_to_vec(rv);
    // convert R vector of pivots to std::vector
    cppr::rvec<cppr::numeric> pivots_r{rpivots};
    std::vector<ldat::vec::vecsize> pivots;
    for (R_xlen_t i = 0; i < pivots_r.length(); ++i) {
      if (cppr::is_na(pivots_r[i]))
        throw std::runtime_error("Missing values in the pivots");
      pivots.push_back(pivots_r[i] - 1);
    }
    // call visitor
    psort_visitor visitor(pivots);
    v->visit(&visitor);
    return R_NilValue;
    CPPRCATCH
  }
}

