# Earth surface evolution: a Phanerozoic gridded dataset of Global Plate Model reconstructions 

Author(s): [Lewis A. Jones](mailto:LewisA.Jones@outlook.com) and [Mathew Domeier](mailto:mathewd@uio.no)

This repository contains the data and code required to run the analyses and results of the article, "Earth surface evolution: a Phanerozoic gridded dataset of Global Plate Model reconstructions " (Jones and Domeier, 2023). 

To cite the paper: 

> Jones, L.A. and Domeier, M.M. 2023. Earth surface evolution: a Phanerozoic gridded dataset of Global Plate Model reconstructions. (TBC).

To cite this repository:

> Jones, L.A. and Domeier, M.M. 2023. Earth surface evolution: a Phanerozoic gridded dataset of Global Plate Model reconstructions. GitHub Repository: https://github.com/LewisAJones/GPM-reconstruction-grids

-------

## Data
All data used in preparation of this article are included in this repository.

* `data/` contains `pbdb_data.csv`, a dataset of fossil collections from [the Palaeobiology Database](https://paleobiodb.org/#/).
* `data/` contains `resolution_2.RDS`, an example reconstruction file for H3 resolution 2 using the Merdith et al. (2021) Global Plate Model.

NOTE: All reconstructions files are deposited on a dedicated [Zenodo repository]().

-------

## Python

* `python/` contains the subfolder `plate_models`, which contains the static polygons and rotation files for the five Global Plate Models used here:

| Abbreviation | Temporal coverage | Reference                |
| ------------ | ----------------- | ------------------------ |
| WR13         | 0–550 Ma          | (Wright et al., 2013)    |
| MA16         | 0–410 Ma          | (Matthews et al., 2016)  |
| TC16         | 0–540 Ma          | (Torsvik and Cocks, 2016)|
| SC16         | 0–1100 Ma         | (Scotese, 2016)          |
| ME21         | 0–1000 Ma         | (Merdith et al., 2021)   |

* `python/` contains `make_grids.ipynb`, which provides a Jupyter Notebook documenting the process used to make the reconstruction grids.
* `python/` contains `look_up.ipynb`, which provides a Jupyter Notebook which can be used to generate reconstructed coordinates for user data from the reconstruction files.

-------

## R

* `R/` contains the subfolder `figures`, which provides the R code used to generate figures for the article.
* `R/` contains `look_up.R`, which provides an R script which can be used to generate reconstructed coordinates for user data from the reconstruction files.



 
