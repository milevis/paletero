
paletero <- function(palette,  n = NULL, alpha = NULL, reverse = FALSE){
  if(!palette %in% availablePalettes())
    stop("Palette not available")
  if(palette %in% getBrewerPalettes())
    return(brewer_pal(palette, n = n, alpha = alpha, reverse = reverse))
  if(palette %in% getViridisPalettes())
    return(viridis_pal(palette, n = n, alpha = alpha, reverse = reverse))
}

paletero_pal <- function(palette, n = NULL, alpha = NULL, reverse = FALSE){
  colors <- paletero(palette, n = n, alpha = alpha, reverse = reverse)
  ramp <- colour_ramp(colors)
}


viridis_pal <- function(palette, n = NULL, alpha = NULL, reverse = FALSE){
  viridis_palettes <- getViridisPalettes()
  direction <- ifelse(reverse, -1, 1)
  if(!palette %in% viridis_palettes)
    stop("Palette not in viridis")
  do.call(palette, list(n = n, direction = direction, alpha = alpha))
}


brewer_pal <- function(palette, n = NULL, alpha = NULL, reverse = FALSE) {
  # Borrowed from https://github.com/rstudio/leaflet/blob/master/R/colors.R

  # # Seq palette
  # # Blues BuGn BuPu GnBu Greens Greys Oranges OrRd PuBu PuBuGn PuRd Purples RdPu Reds YlGn YlGnBu YlOrBr YlOrRd
  # # Divergent
  # # BrBG PiYG PRGn PuOr RdBu RdGy RdYlBu RdYlGn Spectral
  # # Qualitative
  # # Accent Dark2 Paired Pastel1 Pastel2 Set1 Set2 Set3
  # # c("Blues", "BuGn", "BuPu", "GnBu", "Greens", "Greys", "Oranges", "OrRd", "PuBu", "PuBuGn", "PuRd", "Purples", "RdPu", "Reds", "YlGn", "YlGnBu", "YlOrBr", "YlOrRd", "BrBG", "PiYG", "PRGn", "PuOr", "RdBu", "RdGy", "RdYlBu", "RdYlGn", "Spectral", "Accent", "Dark2", "Paired", "Pastel1", "Pastel2", "Set1", "Set2", "Set3")
  brewer_palettes <- getBrewerPalettes()
  n_max <- RColorBrewer::brewer.pal.info[palette, "maxcolors"]
  if (is.null(n))
    n <- RColorBrewer::brewer.pal.info[palette, "maxcolors"]
  #colors <- RColorBrewer::brewer.pal(max(3, n), palette)
  colors <- RColorBrewer::brewer.pal(n_max, palette)
  if (n == 1) {
    colors <- colors[1]
  } else if (n == 2) {
    #colors <- colors[c(1,n_max)]
    colors <- colors[c(1,2)]
  } else if (n > 2){
    colors <- colors[1:n]
  }
  if(reverse) return(rev(colors))
  if(!is.null(alpha)) return(paste0(colors, strtoi(alpha)))
  colors
}

getBrewerPalettes <- function(){
  c("Blues", "BuGn", "BuPu", "GnBu", "Greens", "Greys", "Oranges", "OrRd", "PuBu", "PuBuGn", "PuRd", "Purples", "RdPu", "Reds", "YlGn", "YlGnBu", "YlOrBr", "YlOrRd", "BrBG", "PiYG", "PRGn", "PuOr", "RdBu", "RdGy", "RdYlBu", "RdYlGn", "Spectral", "Accent", "Dark2", "Paired", "Pastel1", "Pastel2", "Set1", "Set2", "Set3")
}

getViridisPalettes <- function(){
  c("viridis","magma", "plasma","inferno")
}