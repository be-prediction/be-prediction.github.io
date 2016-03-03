"""
    Based on pwr.r.test from the R-package "pwr"
    Github: https://github.com/heliosdrm/pwr
    CRAN: http://cran.r-project.org/web/packages/pwr/
"""
from math import sqrt, pow, atanh
from scipy.stats import t, norm

def onesiderpower(n, r, level, tside):
    if tside == 1:
        r = -r
    ttt = -t.ppf(level, n-2)
    rc = sqrt(pow(ttt, 2) / (pow(ttt, 2) + n - 2))
    zrc = atanh(rc) # + rc/(2 * (n - 1))
    zr = atanh(r) + r / (2 * (n-1))
    power = norm.cdf((zr-zrc) * sqrt(n - 3))
    return power

def twosiderpower(n, r, level):
    ttt = -t.ppf(level/2, n-2)
    r = abs(r)
    rc = sqrt(pow(ttt, 2) / (pow(ttt, 2) + n - 2))
    zrc = atanh(rc) # + rc/(2 * (n - 1))
    zr = atanh(r) + r / (2 * (n-1))
    power = norm.cdf((zr-zrc) * sqrt(n - 3)) + norm.cdf((-zr-zrc) * sqrt(n - 3))
    return power


def rpower(n=None, r=None, power=None, level=0.05, alternative="two-sided"):
    """Temp"""
    assert sum(x is None for x in [n, r, power]) == 1,\
    "exactly one of n, r, power, and sig.level must be None"
    assert level is not None and isinstance(level, float) and (0 <= level <= 1),\
    "level must be float in [0, 1]"
    if power is not None:
        assert isinstance(power, float) and (0 <= level <= 1),\
        "power must be float in [0, 1]"
    if r is not None:
        assert isinstance(r, float) and (-1 <= r <= 1),\
        "r must be float in [-1, 1]"
    if n is not None:
        n = float(n)
        assert n >= 4,\
        "number of observations must be at least 4"
    assert alternative in ["two-sided", "less", "greater"],\
    "Alternative must be one of: two-sided / less / greater"
    if alternative == "less":
        tside = 1
    elif alternative == "two-sided":
        tside = 2
    elif alternative == "greater":
        tside = 3

    # MISSING POWER:
    if power is None:
        if tside in [1, 3]:
            power = onesiderpower(n, r, level, tside)
        elif tside == 2:
            power = twosiderpower(n, r, level)
        return power

    # MISSING N
    if n is None:
        iteration = 0
        searchrange = [4+1e-10, 1e+07]
        temppower = 0
        ntemp = 0
        while abs(temppower - power) >= 0.00001 and iteration <= 5000:
            iteration += 1
            ntemp = float(sum(searchrange)/2)
            if tside in [1, 3]:
                temppower = onesiderpower(ntemp, r, level, tside)
            elif tside == 2:
                temppower = twosiderpower(ntemp, r, level)
            if temppower > power:
                searchrange = [searchrange[0], ntemp]
            else:
                searchrange = [ntemp, searchrange[1]]
        if iteration < 1000:
            return ntemp
        else:
            raise Warning("Search method did not converge.")

    # MISSING R
    if r is None:
        iteration = 0
        if tside in [1, 3]:
            searchrange = [-1+1e-10, 1 - 1e-10]
        elif tside == 2:
            searchrange = [1e-10, 1 - 1e-10]
        temppower = 0
        rtemp = 0
        while abs(temppower - power) >= 0.00001 and iteration <= 5000:
            iteration += 1
            rtemp = float(sum(searchrange)/2)
            if tside in [1, 3]:
                temppower = onesiderpower(n, rtemp, level, tside)
            elif tside == 2:
                temppower = twosiderpower(n, rtemp, level)
            if temppower > power and tside == 1:
                searchrange = [rtemp, searchrange[1]]
            elif tside == 1:
                searchrange = [searchrange[0], rtemp]
            elif temppower > power:
                searchrange = [searchrange[0], rtemp]
            else:
                searchrange = [rtemp, searchrange[1]]
        if iteration < 1000:
            return rtemp
        else:
            raise Warning("Search method did not converge.")
