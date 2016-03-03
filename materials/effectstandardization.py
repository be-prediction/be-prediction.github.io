"""
This module contains relevant functions and classes to standardize
and combine effect sizes from different statistical tests.

Relevant references are:
[1] Field, A. P. (2001). Meta-analysis of correlation coefficients: a Monte Carlo comparison of fixed-and random-effects methods. Psychological Methods, 6(2), 161.
[2] Lipsey, M. W., & Wilson, D. B. (2001). Practical meta-analysis (Vol. 49). Sage publications Thousand Oaks, CA. Retrieved from http://www2.jura.uni-hamburg.de/instkrim/kriminologie/Mitarbeiter/Enzmann/Lehre/StatIIKrim/Wilson.pdf
[3] Open Science Collaboration. (2015). Estimating the reproducibility of psychological science. Science, 349(6251). http://doi.org/10.1126/science.aac4716
[4] Rosenberg, M. S., & Plaistow, S. (2010). A generalized formula for converting chi-square tests to effect sizes for meta-analysis. PloS One, 5(4). Retrieved from http://dx.plos.org/10.1371/journal.pone.0010059
[5] Viechtbauer, W., & others. (2010). Conducting meta-analyses in R with the metafor package. Journal of Statistical Software, 36(3), 1-48.
[6] Fisher transformation. (2015, November 23). In Wikipedia, the free encyclopedia. Retrieved from https://en.wikipedia.org/w/index.php?title=Fisher_transformation&oldid=691927443
[7] Leek, J. T., Patil, P., & Peng, R. D. (2015). A glass half full interpretation of the replicability of psychological science. arXiv Preprint arXiv:1509.08968. Retrieved from http://arxiv.org/abs/1509.08968


"""

import math
from scipy.stats import norm
import numpy
import sys
sys.path.insert(0, '') # Enter path here
from pwr_r_test import *


class Study(object):
    def __init__(self, name, original=None, replication=None, meta=None):
        self.name = name
        self.original = original
        self.replication = replication
        self.meta = meta
        self.predinterval95 = rpredint(self.original.getr(), self.original.getN(), self.replication.getN(), 0.95)

    def setoriginal(self, original):
        self.original = original

    def setreplication(self, replication):
        self.replication = replication

    def setmeta(self, meta):
        self.meta = meta

    def getoriginal(self):
        return self.original

    def getreplication(self):
        return self.replication

    def getmeta(self):
        return self.meta

    def getpredinterval95(self):
        return self.predinterval95

    def __str__(self):
        return self.name + \
        "\nOriginal:" + \
        "\nStandardized effect (r): " + str(self.original.rstat) + \
        "\nP-value (for r): " + str(self.original.pvalue) + \
        "\n95% Confidence interval around r: " + str(self.original.rinterval) +\
        "\n\nReplication:"+ \
        "\nStandardized effect (r): " + str(self.replication.rstat) + \
        "\nP-value (for r): " + str(self.replication.pvalue) + \
        "\n95% Confidence interval around r: " + str(self.replication.rinterval) +\
        "\n\nMeta:" + \
        "\nStandardized effect (r): " + str(self.meta.rstat) + \
        "\nP-value (for r): " + str(self.meta.pvalue) + \
        "\n95% Confidence interval around r: " + str(self.meta.rinterval)

class Effectsize(object):
    validtypes = ['t', 'Z', 'F', 'r', 'Chi2']

    def __init__(self):
        self.stat = None
        self.df1 = None
        self.df2 = None
        self.samplesize = None
        self.rstat = None
        self.rinterval90 = None
        self.rinterval95 = None
        self.pvalue = None
        self.e33 = None


    def settype(self, stattype):
        validtypes = ['t', 'Z', 'F', 'r', 'Chi2']
        assert stattype in validtypes, "Only valid stat types are: %s" % validtypes
        self.stattype = stattype

    def setstat(self, stat):
        self.stat = float(stat)

    def setdf1(self, df1):
        self.df1 = float(df1)

    def setdf2(self, df2):
        self.df2 = float(df2)

    def setN(self, samplesize):
        self.samplesize = float(samplesize)

    def setpval(self, pvalue):
        self.pvalue = pvalue

    def setr(self, rstat):
        self.rstat = rstat

    def setrinterval(self, interval):
        self.rinterval = interval

    def gettype(self):
        return self.stattype

    def getstat(self):
        return self.stat

    def getdf1(self):
        return self.df1

    def getdf2(self):
        return self.df2

    def getN(self):
        return self.samplesize

    def getr(self):
        return self.rstat

    def getrinterval90(self):
        return self.rinterval90

    def getrinterval95(self):
        return self.rinterval95

    def getpval(self):
        return self.pvalue

    def gete33(self):
        return self.e33

    def getvalidtypes(self):
        return self.validtypes

    def update(self):
        if self.stattype == 't':
            self.rstat = ttor(self.stat, self.df2)
        elif self.stattype == 'F':
            self.rstat = ftor(self.stat, self.df1, self.df2)
        elif self.stattype == 'r':
            self.rstat = self.stat
        elif self.stattype == 'Chi2':
            self.rstat = chi2tor(self.stat, self.samplesize)
        elif self.stattype == 'Z':
            self.rstat = ztor(self.stat, self.samplesize)

        self.rinterval95 = rconfint(self.rstat, self.samplesize, 0.95)
        self.rinterval90 = rconfint(self.rstat, self.samplesize, 0.90)
        self.pvalue = pvalue(self.rstat, self.samplesize)
        self.e33 = rpower(n=self.samplesize,power=1.0/3)

    def __str__(self):
        return "Stat type: " + self.stattype + \
        "\nSample size (or clusters): " + str(self.samplesize) + \
        "\nStandardized effect (r): " + str(self.rstat) + \
        "\nP-value: " + str(self.pvalue) + \
        "\n95% Confidence interval around r: " + str(self.rinterval)

def autoeffectsize():
    """ Step by step guide to input an effect size """
    effect = Effectsize()

    estype = str(raw_input('Type of statistic: '))
    assert estype in effect.getvalidtypes(), "Only valid stat types are: %s" % effect.getvalidtypes()
    effect.settype(estype)
    effect.setstat(float(raw_input('Stat value: ')))
    effect.setN(float(raw_input('Sample size (or clusters): ')))
    if effect.gettype() == 't':
        effect.setdf2(float(raw_input('Degrees of freedom: ')))
    elif effect.gettype() == 'F':
        effect.setdf1(float(raw_input('Numerator degrees of freedom: ')))
        effect.setdf2(float(raw_input('Denominator degrees of freedom: ')))

    effect.update()
    return effect

def metaeffect(original, replication):
    """ Takes two Effectsize objects and calculates the fixed-effects
        weighted metaeffect. See references 1,2 & 5. """
    origw = original.getN()-3
    origz = rtofisherz(original.getr())
    repw = replication.getN()-3
    repz = rtofisherz(replication.getr())
    metaz = (repw * repz + origw * origz) / (repw + origw)
    meta = Effectsize()
    meta.settype('r')
    meta.setstat(fisherztor(metaz))
    meta.setN(original.getN() + replication.getN() - 3) # -3 to account for two samples
    meta.update()
    return meta

def rtofisherz(stat):
    """ Fisher transformation of r to z.
        Expects inputs as floats.
        See reference 6. """
    return math.atanh(stat)

def fisherztor(stat):
    """ Fisher transformation of z to r.
        Expects inputs as floats.
        See reference 6. """
    return math.tanh(stat)

def ztor(stat, samplesize):
    """ Transformaiton of Z stat from standard normal distribution to r.
        Expects inputs as floats.
        See reference 3. """
    fisherz = stat * math.sqrt(1/(samplesize-3))
    return fisherztor(fisherz)

def ttor(stat, df2):
    """ Transformaiton of t stat to r.
        Expects inputs as floats.
        See reference 3. """
    numerator = math.pow(stat, 2)
    denominator = math.pow(stat, 2) + df2
    return numpy.sign(stat) * math.sqrt(numerator / denominator)

def ftor(stat, df1, df2):
    """ Transformaiton of F stat to r.
        Expects inputs as floats.
        See reference 3. """
    return math.sqrt((stat*(df1 / df2)) / (((stat*df1) / df2) + 1))*math.sqrt(1/df1)

def chi2tor(stat, samplesize):
    """ Transformaiton of Chi2 stat  to r.
    Expects inputs as floats.
        See references 3 & 4. """
    return math.sqrt(stat/samplesize)

def rconfint(stat, samplesize, width):
    """ Confidence interval around r using the Fisher transformation.
        Expects inputs as floats.
        See reference 3 & 6. """
    probability = 1-(1-width)/2
    zstat = rtofisherz(stat)
    samplesize = float(samplesize)
    zvar = 1/(samplesize-3)
    zlower = zstat - norm.ppf(probability) * math.sqrt(zvar)
    zupper = zstat + norm.ppf(probability) * math.sqrt(zvar)
    rinterval = []
    rinterval.append(fisherztor(zlower))
    rinterval.append(fisherztor(zupper))
    return rinterval

def rpredint(stat, origsamplesize, repsamplesize, width):
    """ Confidence interval around r using the Fisher transformation.
        Expects inputs as floats.
        See reference 7. """
    probability = 1-(1-width)/2
    zstat = rtofisherz(stat)
    zvarorig = 1/(origsamplesize-3)
    zvarrep = 1/(repsamplesize-3)
    zlower = zstat - norm.ppf(probability) * math.sqrt(zvarorig+zvarrep)
    zupper = zstat + norm.ppf(probability) * math.sqrt(zvarorig+zvarrep)
    predinterval = []
    predinterval.append(fisherztor(zlower))
    predinterval.append(fisherztor(zupper))
    return predinterval

def pvalue(stat, samplesize):
    """ P-value for r using the Fisher transformation.
        Expects inputs as floats.
        See reference 6. """
    zstat = rtofisherz(stat)
    zvar = 1/(samplesize-3)
    normstat = abs(zstat / math.sqrt(zvar))
    return 2*(1-norm.cdf(normstat))

def stataformatstudies(studies):
    """ Assumes studies is a list of studies """
    print "*********************************"
    print "*** Standardized effect sizes ***"
    print "*********************************"
    for type in ['orig', 'rep', 'meta']:
        if type == 'orig':
            text = 'original'
        elif type == 'rep':
            text = 'replication'
        else:
            text = 'meta'
        print "gen e" + type + " = ."
        print "label var e" + type + " \"Effect size of " + text + " study\""
        print "gen e" + type + "l95 = ."
        print "label var e" + type + "l95 \"Lower bound of 95% interval around " + text + " effect size (r)\""
        print "gen e" + type + "u95 = ."
        print "label var e" + type + "u95 \"Upper bound of 95% interval around " + text + " effect size (r)\""
        print "gen e" + type + "l90 = ."
        print "label var e" + type + "l90 \"Lower bound of 90% interval around " + text + " effect size (r)\""
        print "gen e" + type + "u90 = ."
        print "label var e" + type + "u90 \"Upper bound of 90% interval around " + text + " effect size (r)\""
        if type == "orig":
            print "gen e33orig = ."
            print "label var e33orig \"Effect size (r) that the original study had 33% power to detect\""
            print "gen eorigpredl95 = ."
            print "label var eorigpredl95 \"Lower bound of 95% prediction interval around original effect size (3)\""
            print "gen eorigpredu95 = ."
            print "label var eorigpredu95 \"Upper bound of 95% prediction interval around original effect size (3)\""
    print ""
    i = 0
    for study in studies:
        if study is not None:
            stataformatstudy(study, i)
        i += 1
    for type in ['rep', 'meta']:
        if type == 'orig':
            text = 'original'
        elif type == 'rep':
            text = 'replication'
        else:
            text = 'meta'
        print ""
        print "gen e" + type + "rel=e" + type + "/eorig"
        print "gen e" + type + "rell95=e" + type + "l95/eorig"
        print "gen e" + type + "relu95=e" + type + "u95/eorig"
        print "label var e" + type + "rel \"Normalized effect size of " + text + " study\""
        print "label var e" + type + "rell95 \"Lower bound of 95% interval around normalized " + text + " effect\""
        print "label var e" + type + "relu95 \"Upper bound of 95% interval around normalized " + text + " effect\""


def stataformatstudy(study, number):
    """ Takes a Study object as input """
    effects = [[study.getoriginal(), 'orig'], [study.getreplication(), 'rep'], [study.getmeta(), 'meta']]
    print "// Study " + str(number)
    # Normalize all original effect sizes as positive
    # Simply flip the confidence interval
    if study.getoriginal().getr() < 0:
        sign = -1
        lowernum = 1
        uppernum = 0
    else:
        sign = 1
        lowernum = 0
        uppernum = 1
    for effect in effects:
        if effect[0] is not None:
            print "replace e" + effect[1] + " = " + str(sign * effect[0].getr()) + \
            " if study==" + str(number)
            print "replace e" + effect[1] + "l90 = " + \
            str(sign * effect[0].getrinterval90()[lowernum]) + \
            " if study==" + str(number)
            print "replace e" + effect[1] + "u90 = " + \
            str(sign * effect[0].getrinterval90()[uppernum]) + \
            " if study==" + str(number)
            print "replace e" + effect[1] + "l95 = " + \
            str(sign * effect[0].getrinterval95()[lowernum]) + \
            " if study==" + str(number)
            print "replace e" + effect[1] + "u95 = " + \
            str(sign * effect[0].getrinterval95()[uppernum]) + \
            " if study==" + str(number)
            if effect[1]=='orig':
                print "replace e33orig = " + \
                str(effect[0].gete33()) + \
                " if study==" + str(number)
                print "replace eorigpredl95 = " + \
                str(sign * study.getpredinterval95()[lowernum]) + \
                " if study==" + str(number)
                print "replace eorigpredu95 = " + \
                str(sign * study.getpredinterval95()[uppernum]) + \
                " if study==" + str(number)
            print ""

def normalize(effect, normalization):
    """ Standardizes an effect size's correlation coefficient (r)
        and confidence interval by any floating point number """
    temp = Effectsize()
    temp.settype('r')
    temp.setstat(effect.getr()/normalization)
    temp.setr(temp.getstat())
    interval = effect.getrinterval95()
    interval[0] = interval[0]/normalization
    interval[1] = interval[1]/normalization
    temp.setrinterval(interval)
    return temp

