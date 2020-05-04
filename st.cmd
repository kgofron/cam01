#!/ad-nfs/epics/prod/Deb8/production/areaDetector/ADProsilica/iocs/prosilicaIOC/bin/linux-x86_64/prosilicaApp st.cmd
errlogInit(20000)

< unique.cmd
< /ad-nfs/epics/prod/Deb8/production/envPaths

dbLoadDatabase("$(ADPROSILICA)/iocs/prosilicaIOC/dbd/prosilicaApp.dbd")
prosilicaApp_registerRecordDeviceDriver(pdbbase)

# prosilicaConfig(portName,    # The name of the asyn port to be created
#                 cameraId,    # Unique ID, IP address, or IP name of the camera
#                 maxBuffers,  # Maximum number of NDArray buffers driver can allocate. 0=unlimited
#                 maxMemory,   # Maximum memory bytes driver can allocate. 0=unlimited
#                 priority,    # EPICS thread priority for asyn port driver 0=default
#                 stackSize,   # EPICS thread stack size for asyn port driver 0=default
#                 maxPvAPIFrames) # Number of frames to allocate in PvAPI driver. Default=2.
# The simplest way to determine the uniqueId of a camera is to run the Prosilica GigEViewer application, 
# select the camera, and press the "i" icon on the bottom of the main window to show the camera information for this camera. 
# The Unique ID will be displayed on the first line in the information window.
#prosilicaConfig("$(PORT)", "$(UID-NUM)", 50, 0)
#prosilicaConfig("$(PORT)", "$(CAM-IP)", -1, -1)
#prosilicaConfig("$(PORT)", "$(CAM-IP)",  50, 0, 0, 0, 10)
prosilicaConfig("$(PORT)", "$(CAM-IP)",  50, 0)

asynSetTraceIOMask("$(PORT)",0,2)
#asynSetTraceMask("$(PORT)",0,255)

dbLoadRecords("$(ADPROSILICA)/db/prosilica.template","P=$(PREFIX),R=cam1:,PORT=$(PORT),ADDR=0,TIMEOUT=1")
dbLoadRecords("/ad-nfs/epics/prod/Deb8/production/iocStats/db/iocAdminSoft.db", "IOC=$(CTPREFIX)")

# Create a standard arrays plugin, set it to get data from first Prosilica driver.
NDStdArraysConfigure("Image1", 5, 0, "$(PORT)", 0, 0)

# Use (TYPE=Int8,FTVL=UCHAR), if you only want to use the Prosilica in 8-bit mode (or color mode). It uses an 8-bit waveform record
# Use (TYPE=Int16,FTVL=SHORT), if you want to use the Prosilica in 8,12 or 16-bit modes.  
# NELEMENTS is set large enough for a 1360x1024x3 image size, which is the number of pixels in RGB images from the GC1380C color camera. 
# NELEMENTS is set large enough for a 1360x1024 image size, which is the number of pixels in B/W images from the GC1380B mono camera.
# Must be at least as big as the maximum size of your camera images
dbLoadRecords("$(ADCORE)/db/NDStdArrays.template", "P=$(PREFIX),R=image1:,PORT=Image1,ADDR=0,TIMEOUT=1,NDARRAY_PORT=$(PORT),TYPE=$(NDTYPE),FTVL=$(NDFTVL),NELEMENTS=$(NELMT)")

# Load all other plugins using commonPlugins.cmd
< $(ADCORE)/iocBoot/commonPlugins.cmd
set_requestfile_path("$(ADPROSILICA)/prosilicaApp/Db")
set_requestfile_path("$(ADPROSILICA)/iocs/prosilicaIOC/iocBoot/iocProsilica")

#system("install -m 777 -d $(TOP)/as/save")
#system("install -m 777 -d $(TOP)/as/req")

#access security
#asSetFilename("/cf-update/acf/default.acf")

#asynSetTraceMask("$(PORT)",0,255)
#asynSetTraceMask("$(PORT)",0,9)
asynSetTraceIOMask("$(PORT)",0,4)

iocInit()

#must be after iocInit()
# save things every thirty seconds
create_monitor_set("auto_settings.req", 30,"P=$(PREFIX)")

# Channel Finder
dbl > ./records.dbl
#system "cp ./records.dbl /cf-update/$(HOSTNAME).$(IOCNAME).dbl"

# dbpf "$(PREFIX)cam1:GevSCPSPacketSiz", "8228"

