box::use(
  assertthat[assert_that],
  glue[glue],
  sf[
    st_geometry_type,
    st_union,
  ],
  tigris[
    urban_areas,
    zctas,
    ]
)

# Define helpers
is_contiguous_polygon <- function(sf_object) {
  # Validate input sf object
  assert_that(all(st_geometry_type(sf_object) %in% c("POLYGON", "MULTIPOLYGON")))
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

# Data prep
uas <- urban_areas()
pdx_ua <- uas[grep("Portland, OR--WA", uas$NAME10), ]

# Discontiguous polygons
or_zctas <- zctas(state = "OR", year = 2010)
is_contiguous_polygon(or_zctas)
# [1] FALSE

# Contiguous polygons
pdx_zctas <- or_zctas[pdx_ua, ]
is_contiguous_polygon(pdx_zctas)
# [1] TRUE
