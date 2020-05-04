#Prosilica GC1290/GT1290: 1280 * 960  = 1228800; MAX_ARRAY = 2457600 Bytes
#Prosilica Mako G-125B:   1292 * 964  = 1245488; MAX_ARRAY = 2490976 Bytes
#Prosilica GX1920:        1936 * 1456 = 2818816; MAX_ARRAY = 5637632 Bytes

epicsEnvSet("ENGINEER",                 "Chanaka De Silva, x2962")
epicsEnvSet("LOCATION",                 "07BM")
epicsEnvSet("TOP",                      "${PWD}")
epicsEnvSet("PORT",                     "CAM")

epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST",  "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST",       "10.7.128.255")
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", "50000000")

epicsEnvSet("CAM-IP",                   "10.7.129.21")
epicsEnvSet("PREFIX",                   "XF:07BM-BI{Mir:Col}")
epicsEnvSet("CTPREFIX",                 "XF:07BM-CT{IOC:cam01}")
epicsEnvSet("HOSTNAME",                 "xf07bm-ioc1")
epicsEnvSet("IOCNAME",                  "cam01")

epicsEnvSet("QSIZE",                    "20")
epicsEnvSet("NCHANS",                   "2048")
epicsEnvSet("HIST_SIZE",                "4096")
epicsEnvSet("XSIZE",                    "1280")
epicsEnvSet("YSIZE",                    "960")
epicsEnvSet("NELMT",                    "2457600")
epicsEnvSet("NDTYPE",                   "Int16") #Int8
epicsEnvSet("NDFTVL",                   "SHORT") #UCHAR
epicsEnvSet("CBUFFS",                   "500")

epicsEnvSet("SUPPORT_DIR", "/ad-nfs/epics/prod/Deb8/production")
