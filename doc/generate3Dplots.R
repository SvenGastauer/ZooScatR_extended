## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(ZooScatR)
library(zsext)

## ----simulation---------------------------------------------------------------
#list of shape sources
shapes <- list.files(paste0(system.file(package="ZooScatR"),"/extdata/profiles/"),full.names=TRUE)

# get the filename of the initial config as it comes with the package
fname <- paste0(system.file(package="ZooScatR"),"/extdata/configs/config_0.dat")

#Read the parameter file
para <- ZooScatR::read_para(fname)

#Select one of the predefined shapes
para$shape$prof_name = shapes[4]

#set length 
para$shape$L<- 38


#set L/a using L/a value
#para$shape$L_a <- 20
#set L/a using a
para = set_la(para, a=2.5)

#set tapering
para$shape$taper_sm = 0

#define number of circular elements
para$simu$ni = 200

#set frequencies
para$simu$var0=10 #minimum frequency
para$simu$var1=450 #maximum frequency
# manual way or new function
#para$simu$n = para$simu$var1 - para$simu$var0 +1 #set 1 kHz intervals
para = set_res(para,1)


#set c
misc = list(cw=1480)
res <- bscat(para=para, misc=misc)
res$shplot

## ----3d_plot, echo=FALSE------------------------------------------------------
zsext::plot_3D(para)

## ----scattering, echo=FALSE---------------------------------------------------
res$rplot

## ----para1--------------------------------------------------------------------
#Select one of the predefined shapes
para$shape$prof_name = shapes[5]

res <- bscat(para=para, misc=misc)
print(res$shplot)

## ----para1_3d-----------------------------------------------------------------
zsext::plot_3D(para)

## ----para1_scat---------------------------------------------------------------

print(res$rplot)

## ----para2--------------------------------------------------------------------
para$simu$ni = 10

res <- bscat(para=para, misc=misc)
print(res$shplot)

## ----para2_3d-----------------------------------------------------------------
zsext::plot_3D(para)

## ----para2_scat---------------------------------------------------------------

print(res$rplot)

## ----para3--------------------------------------------------------------------
para$shape$L_a =10
para$simu$ni = 200

res <- bscat(para=para, misc=misc)
print(res$shplot)

## ----para3_3d-----------------------------------------------------------------
zsext::plot_3D(para)

## ----para3_scat---------------------------------------------------------------

print(res$rplot)

## ----para4--------------------------------------------------------------------
para$shape$L_a =30

res <- bscat(para=para, misc=misc)
print(res$shplot)

## ----para3_4d-----------------------------------------------------------------
zsext::plot_3D(para)

## ----para4_scat---------------------------------------------------------------

print(res$rplot)

