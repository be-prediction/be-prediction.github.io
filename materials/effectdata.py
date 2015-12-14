from scipy.stats import t, norm
import sys
sys.path.insert(0, '/Users/es.3386/Google Drive/Doktorand/Behavioral pred. markets/Effect standardization')
from effectstandardization import *

STUDIES = [None for x in range(19)]

# STUDY 1
rep1 = Effectsize()
rep1.settype('t')
rep1.setstat(1.41)
rep1.setN(318)
rep1.setdf2(316)
rep1.update()

orig1 = Effectsize()
orig1.settype('t')
orig1.setstat(2.02)
orig1.setN(120)
orig1.setdf2(118)
orig1.update()

study1 = Study("Study 01 - Abeler et al. 2011", orig1, rep1, metaeffect(orig1, rep1))
STUDIES[1] = study1


# STUDY 2
rep2 = Effectsize()
rep2.settype('t')
rep2.setstat(-2.54)
rep2.setN(119) # Clustered
rep2.setdf2(116)
rep2.update()

orig2 = Effectsize()
orig2.settype('t')
orig2.setstat(-1.96)
orig2.setN(39) # Clustered
orig2.setdf2(36)
orig2.update()

study2 = Study("Study 02 - Ambrus & Greiner 2012", orig2, rep2, metaeffect(orig2, rep2))
STUDIES[2] = study2


# STUDY 3
rep3 = Effectsize()
rep3.settype('Z')
rep3.setstat(3.250)
rep3.setN(20)
rep3.update()

orig3 = Effectsize()
orig3.settype('Z')
orig3.setstat(2.722)
orig3.setN(12)
orig3.update()

study3 = Study("Study 03 - Bartling et al. 2012", orig3, rep3, metaeffect(orig3, rep3))
STUDIES[3] = study3


# STUDY 4
rep4 = Effectsize()
rep4.settype('Z')
rep4.setstat(2.9948)
rep4.setN(65) # Sum of group 1 and 2
rep4.update()

orig4 = Effectsize()
orig4.settype('Z')
orig4.setstat(2.5594)
orig4.setN(43) # Sum of group 1 and 2
orig4.update()

study4 = Study("Study 04 - Charness & Dufwenberg 2011", orig4, rep4, metaeffect(orig4, rep4))
STUDIES[4] = study4


# STUDY 5
rep5 = Effectsize()
rep5.settype('Z')
rep5.setstat(0.57)
rep5.setN(14) # Clustered
rep5.update()

orig5 = Effectsize()
orig5.settype('Z')
orig5.setstat(2.13)
orig5.setN(6) # Clustered
orig5.update()

study5 = Study("Study 05 - Chen & Chen 2011", orig5, rep5, metaeffect(orig5, rep5))
STUDIES[5] = study5


# STUDY 6
rep6 = Effectsize()
rep6.settype('t')
rep6.setstat(7.7135)
rep6.setN(780)
rep6.setdf2(778)
rep6.update()

orig6 = Effectsize()
orig6.settype('t')
orig6.setstat(3.3291)
orig6.setN(790)
orig6.setdf2(788)
orig6.update()

study6 = Study("Study 06 - de Clippel et al. 2014", orig6, rep6, metaeffect(orig6, rep6))
STUDIES[6] = study6


# STUDY 7
rep7 = Effectsize()
rep7.settype('Z')
rep7.setstat(0.420)
rep7.setN(16)
rep7.update()

orig7 = Effectsize()
orig7.settype('Z')
orig7.setstat(-2.449)
orig7.setN(9)
orig7.update()

study7 = Study("Study 07 - Duffy & Puzzello 2014", orig7, rep7, metaeffect(orig7, rep7))
STUDIES[7] = study7


# STUDY 8
rep8 = Effectsize()
rep8.settype('Z')
rep8.setstat(-3.361)
rep8.setN(16)
rep8.update()

orig8 = Effectsize()
orig8.settype('Z')
orig8.setstat(-3.873)
orig8.setN(21)
orig8.update()

study8 = Study("Study 08 - Dulleck et al. 2011", orig8, rep8, metaeffect(orig8, rep8))
STUDIES[8] = study8


# STUDY 9
rep9 = Effectsize()
rep9.settype('Z')
rep9.setstat(2.23)
rep9.setN(51) # Clustered
rep9.update()

orig9 = Effectsize()
orig9.settype('Z')
orig9.setstat(2.54)
orig9.setN(30) # Clustered
orig9.update()

study9 = Study("Study 09 - Fehr et al. 2013", orig9, rep9, metaeffect(orig9, rep9))
STUDIES[9] = study9


# STUDY 10
rep10 = Effectsize()
rep10.settype('Z')
rep10.setstat(abs(norm.ppf(0.004276/2)))
rep10.setN(40)
rep10.update()

orig10 = Effectsize()
orig10.settype('Z')
orig10.setstat(abs(norm.ppf(4e-11/2)))
orig10.setN(78)
orig10.update()

study10 = Study("Study 10 - Friedman & Oprea 2012", orig10, rep10, metaeffect(orig10, rep10))
STUDIES[10] = study10


# STUDY 11
rep11 = Effectsize()
rep11.settype('Z')
rep11.setstat(-3.79)
rep11.setN(128) # Using subject lever clusters rather than group level
rep11.update()

orig11 = Effectsize()
orig11.settype('Z')
orig11.setstat(-3.45)
orig11.setN(124) # Using subject lever clusters rather than group level
orig11.update()

study11 = Study("Study 11 - Fudenberg et al. 2012", orig11, rep11, metaeffect(orig11, rep11))
STUDIES[11] = study11


# STUDY 12
rep12 = Effectsize()
rep12.settype('Chi2')
rep12.setstat(2.162)
rep12.setN(16)
rep12.update()

orig12 = Effectsize()
orig12.settype('Chi2')
orig12.setstat(8.308)
orig12.setN(12)
orig12.update()

study12 = Study("Study 12 - Huck et al. 2011", orig12, rep12, metaeffect(orig12, rep12))
STUDIES[12] = study12


# STUDY 13
rep13 = Effectsize()
rep13.settype('t')
rep13.setstat(-0.08)
rep13.setN(131) # Clustered
rep13.setdf2(130)
rep13.update()

orig13 = Effectsize()
orig13.settype('t')
orig13.setstat(2.22)
orig13.setN(58)  # Clustered
orig13.setdf2(57)
orig13.update()

study13 = Study("Study 13 - Ifcher & Zarghamee 2011", orig13, rep13, metaeffect(orig13, rep13))
STUDIES[13] = study13


# STUDY 14
rep14 = Effectsize()
rep14.settype('t')
rep14.setstat(2.49)
rep14.setN(48)
rep14.setdf2(46)
rep14.update()

orig14 = Effectsize()
orig14.settype('t')
orig14.setstat(9.41)
orig14.setN(288)
orig14.setdf2(286)
orig14.update()

study14 = Study("Study 14 - Kessler & Roth 2012", orig14, rep14, metaeffect(orig14, rep14))
STUDIES[14] = study14


# STUDY 15
rep15 = Effectsize()
rep15.settype('Z')
rep15.setstat(2.594)
rep15.setN(22)
rep15.update()

orig15 = Effectsize()
orig15.settype('Z')
orig15.setstat(2.402)
orig15.setN(12)
orig15.update()

study15 = Study("Study 15 - Kirchler et al. 2012", orig15, rep15, metaeffect(orig15, rep15))
STUDIES[15] = study15


# STUDY 16
rep16 = Effectsize()
rep16.settype('Z')
rep16.setstat(-3.28)
rep16.setN(112)
rep16.update()

orig16 = Effectsize()
orig16.settype('Z')
orig16.setstat(-4.21)
orig16.setN(160)
orig16.update()

study16 = Study("Study 16 - Kogan et al. 2011", orig16, rep16, metaeffect(orig16, rep16))
STUDIES[16] = study16


# STUDY 17
rep17 = Effectsize()
rep17.settype('Z')
rep17.setstat(1.43)
rep17.setN(144) # Clustered
rep17.update()

orig17 = Effectsize()
orig17.settype('Z')
orig17.setstat(norm.ppf(0.07/2)) # From p-value
orig17.setN(42) # Clustered
orig17.update()

study17 = Study("Study 17 - Kuziemko et al. 2014", orig17, rep17, metaeffect(orig17, rep17))
STUDIES[17] = study17


# STUDY 18:
rep18 = Effectsize()
rep18.settype('t')
rep18.setstat(-1.93)
rep18.setN(248)
rep18.setdf2(243)
rep18.update()

orig18 = Effectsize()
orig18.settype('t')
orig18.setdf2(102)
orig18.setstat(t.ppf(0.03/2, orig18.getdf2())) # From p-value
orig18.setN(104)
orig18.update()

study18 = Study("Study 18 - Ericson & Fuster 2011", orig18, rep18, metaeffect(orig18, rep18))
STUDIES[18] = study18

# Print all:
# for study in STUDIES:
#     if study is not None:
#         print "\n\n"
#         print study

stataformatstudies(STUDIES)
