# ZCTA Contiguity Analysis Project

This R project provides a helper function to assess whether given ZIP Code Tabulation Areas (ZCTAs) are contiguous. It leverages `sf::st_union()` to determine if the input geometries can be distilled down to a single `POLYGON` (contiguous) or `MULTIPOLYGON` (discontiguous) geometry type.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

The project uses `renv` for dependency management. Make sure you have `renv` installed in your R environment:

```r
if (!require(renv)) install.packages("renv")
```

### Installation

1. Clone this repository or download the project to your local machine.
2. Open R or RStudio and set the working directory to the project's root directory.
3. Run `renv::restore()` to install the necessary packages as specified in the `renv.lock` file:

```r
renv::restore()
```

This command will install all the project's dependencies, ensuring that you have the correct versions of each package.

### Usage

The core functionality resides in the `zcta-contiguity.R` script located under the `R/` subdirectory. Follow these steps to execute the script:

1. Ensure you are in the project's root directory.
2. Source the `zcta-contiguity.R` script:

```r
source("R/zcta-contiguity.R")
```

The script performs the following actions:
- **Load Dependencies**: Uses `box::use` to import specific functions from required packages.
- **Define Helpers**: Contains the `is_contiguous_polygon` function for checking if the input spatial feature (ZCTAs) forms a contiguous polygon.
- **Data Preparation**: Retrieves and prepares urban area and ZCTA data for Portland, Oregon, as an example.
- **Contiguity Analysis**: Demonstrates checking for contiguity among ZCTAs in Oregon and specifically within the Portland urban area.

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.
