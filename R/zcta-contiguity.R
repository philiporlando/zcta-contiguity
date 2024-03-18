# Load dependencies ----
box::use(
  assertthat[assert_that],
  glue[glue],
  sf[
    st_geometry_type,
    st_is_valid,
    st_union,
  ],
  tigris[
    urban_areas,
    zctas,
    ]
)

# Define helpers ----
#' Check if Spatial Features are Contiguous
#'
#' Determines whether a given set of spatial features (specifically, polygons or multipolygons)
#' forms a contiguous area. This is done by distilling the input features into a single feature
#' and checking its geometry type. Contiguous features will result in a single POLYGON, whereas
#' discontiguous features will result in MULTIPOLYGON.
#'
#' @param sf_object An `sf` object containing spatial features to be checked for contiguity.
#' Must only contain geometries of type POLYGON or MULTIPOLYGON.
#'
#' @return A logical value: `TRUE` if the spatial features form a contiguous area, `FALSE` if they
#' are discontiguous. If the geometry type of the distilled feature is neither POLYGON nor
#' MULTIPOLYGON, the function stops with an error message.
#'
#' @examples
#' library(sf)
#' library(tigris)
#'
#' # Assuming `uas` and `zctas` are loaded as shown in the script
#' pdx_ua <- uas[grep("Portland, OR--WA", uas$NAME10), ]
#' or_zctas <- zctas(state = "OR", year = 2010)
#' pdx_zctas <- or_zctas[pdx_ua, ]
#'
#' # Check contiguity
#' is_contiguous_polygon(or_zctas) # Expect: FALSE
#' is_contiguous_polygon(pdx_zctas) # Expect: TRUE
is_contiguous_polygon <- function(sf_object) {
  # Validate input sf object
  assert_that(all(st_geometry_type(sf_object) %in% c("POLYGON", "MULTIPOLYGON")))
  assert_that(all(st_is_valid(sf_object)))
  # Distill polygons down to single feature
  single_feature <- st_union(sf_object)
  # If polygons are contiguous, then a POLYGON geometry type will be returned
  geometry_type <- st_geometry_type(single_feature)
  if (geometry_type == "POLYGON") {
    return(TRUE)
  } else if(geometry_type == "MULTIPOLYGON") {
    return(FALSE)
  } else {
    stop(glue("Unexpected geometry type: {geometry_type}"))
  }
}

# Data prep ----
uas <- urban_areas()
pdx_ua <- uas[grep("Portland, OR--WA", uas$NAME10), ]
or_zctas <- zctas(state = "OR", year = 2010)
pdx_zctas <- or_zctas[pdx_ua, ]

# Discontiguous polygons ----
is_contiguous_polygon(or_zctas)
# [1] FALSE

# Contiguous polygons ----
is_contiguous_polygon(pdx_zctas)
# [1] TRUE
