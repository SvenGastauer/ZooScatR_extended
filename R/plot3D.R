#' plot3D function to create a 3D plot of a ZooScatR shape
#' @description Creates a 3D plotly plot of the prolate spheroid or input shape  
#' for ZooScatR, based on the parameters file.
#' @param para a list of parameters as used in ZooScatR
#' @import plotly
#' @import ZooScatR
#' @return a plotly plot object
#' @export
#' @import plotly
#' @import ZooScatR
#' @examples 
#' 
plot3D <- function(para){
  ppp <-  ZooScatR::buildpos(para=para)
  L = para$shape$L
  q = ppp$x
  x = ppp$z
  b = L/2
  a = (ppp$x + ppp$taper)/para$shape$L_a#ppp$x+ppp$taper/para$shape$L_a
  y = a * sqrt(1-(x/b)^2)
  
  nx <- 20
  nz <- length(x)
  
  for (i in seq(1,nz,by=5)){
    zi <- x[i] * rep(1,nx) - min(x)
    ri <- y[i]
    th <- seq(0, 2 * pi, length = nx)
    xi <- ri * cos(th)+ 0.1 
    yi <- ri * sin(th) + 0.1 * y[i] + 2*L
    tmp <- as.data.frame(cbind(zi,xi,yi,i))
    if(i==1){
      out <- tmp
    }else{
      out <- rbind(out,tmp)
    }
  }
  xr <- diff(range(out$zi))
  yr <- diff(range(out$xi))
  zr <- diff(range(out$yi))
  mr <- max(xr,yr,zr)
  
  p<- plot_ly(out, x = ~zi, y = ~xi, z = ~yi, split=~i, type = 'scatter3d', mode = 'lines',
              opacity = 0.5, line = list(width = 6, reverscale = FALSE)) %>%
    layout(scene = list(
      xaxis= list(title = "X (mm)",nticks = 4),
      yaxis = list(title = "Y (mm)",nticks = 4),
      zaxis = list(title = "Z (mm)",nticks = 4),
      aspectratio = list(x = xr/mr, y = yr/mr, z = zr/mr)),
      showlegend=FALSE)
  
  return(p)
}
