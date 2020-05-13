#' Set number of variable to be computed by resolution
#' @description Creates a 3D plotly plot of the prolate spheroid shape input 
#' for ZooScatR, based on the parameters file.
#' @param para a list of parameters as used in ZooScatR
#' @param  res the resolution of the output variable
#' @return a plotly plot object
#' @export
#' 
set_res<- function(para,res=1){
  para$simu$n = (para$simu$var1 - para$simu$var0 + res)/ res
  return(para)
}


#' Compute L/a for given a and L
#' @description Generates L/a based on a radius and L input
#' @param para a list of parameters as used in ZooScatR
#' @param  a maximum radius of the input shape
#' @return a plotly plot object
#' @export
#' 
set_la<- function(para,a=2){
  para$shape$L_a = (para$shape$L / a)
  return(para)
}