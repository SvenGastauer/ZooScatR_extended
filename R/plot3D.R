
#############################################################################
#############################################################################
#' plot_3D function to create a 3D plot of a prolate spheroid
#' @description Creates a 3D plotly plot of the prolate spheroid shape input 
#' for ZooScatR, based on the parameters file.
#' @param para a list of parameters as used in ZooScatR
#' @param  nx number of point constituing circular elements
#' @return a plotly plot object
#' @export
#' @import plotly
#' @import ZooScatR
#' @examples 
#' 
plot_3D <- function(para,nx=100){
  #build from parameters
  ppp <-  ZooScatR::buildpos(para=para)
  #get needed info from parameters
  L = para$shape$L
  nz <- para$simu$ni
  #get positions from buildpos
  x = ppp$x
  z = ppp$z
  #relative radius
  y=ppp$taper/para$shape$L_a
  
  #angles for circular elements
  th <- seq(0, 2 * pi, length = nx)
  
  #circular elements
  zi <- rep(z - min(z),each=length(th))
  xi <- as.vector(t(apply(matrix(th),1,function(o) x + y * cos(o) + 0.1)))
  yi <- as.vector(t(apply(matrix(th),1,function(o) x + y * sin(o) + 0.1)))
  
  #element number
  i =  rep(1:length(ppp$x),each=length(th))
  
  #aspect ratios
  xr <- diff(range(zi)/2)
  yr <- diff(range(xi))/2
  zr <- diff(range(yi))/2
  mr <- max(xr,yr,zr)
  
  
  p<- plot_ly(x = ~zi * L/2, y = ~xi*L, z = ~yi*L, split=~i, type = 'scatter3d', mode = 'lines',
              opacity = 0.5, line = list(width = 6, reverscale = FALSE,color='black')) %>%
    layout(scene = list(
      xaxis= list(title = "X (mm)",nticks = 4),
      yaxis = list(title = "Y (mm)",nticks = 4),
      zaxis = list(title = "Z (mm)",nticks = 4),
      aspectratio = list(x = xr/mr, y = yr/mr, z = zr/mr)),
      showlegend=FALSE)
  
  return(p)
}

