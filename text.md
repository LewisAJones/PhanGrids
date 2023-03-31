# Earth surface evolution: a gridded dataset of Global Plate Model reconstructions 

Lewis A. Jones, Universidade de Vigo
Mathew M. Domeier, University of Oslo

## Abstract

## Background & Summary

In this work, 

We aim to provide 

## Methods

pyGPlates

## Data records
All five reconstruction files are available via the online [Zenodo]() repository along with the code and Global Plate Models used to generate them. The reconstruction files are stored as comma-seperated files which can be easily read by almost any spreadsheet program (e.g. Microsoft Excel and Google Sheets) or programming language (e.g. Python, Julia, and R). The file structure follows a wide-form dataframe structure to ease indexing. Each reconstruction file consists of three initial index columns relating to the h3 cell index, present-day longitude of the cell centroid, and the present-day latitude of the cell centroid. The subsequent columns provide the reconstructed longitudinal and latitudinal coordinate pairs for their respective age of reconstruction in ascending order, indicated by a numerical suffix. Each row contains a unique spatial point on the Earth's surface reconstructed through time.

## Technical validation

## Usage notes
### Efficiency
One clear advantage of using reconstruction files for generating palaeocoordinates for spatial point data is computational efficiency. By reducing the issue down to an indexing problem, estimation of palaeocoordinates can be generated approximately XXX times faster than conventional means via the GPlates Desktop Software [Inlcude Fig]. As an informative example, reconstructing palaeocoordinates using all fossil collections (*n* = XXX) from the [Paleobiology Database]() via the GPlates Desktop Software with the XXX Global Plate Model  takes approximately XXX on a standard laptop (report machine?). On the same machine, palaeocoordinates generated via the reconstruction files took XXX.

- Include efficiency plot here comparing reconstruction speed for varying sample sizes

### Reproducibility
Global Plate Models might 
- Version control
- User error
- Differences in model implementation

### Legacy
Static files = no change, constantly refer to the same model

### Spatial and temporal resolution
One potential limitation with the usage of reconstruction files is the spatial and temporal resolution they offer. Reconstruction of palaeocoordinates for spatial point data using reconstruction grids might require aggregation of the spatial and temporal information. At the spatial scale, this could imply that point data originating from a geological boundary could be errorenous linked to a cell centroid on a different plate to which it originates. However, this issue also exists when reconstructing coordinates using point data as different Global Plate Models diverge in their geographic definition of geological terranes. At temporal scales, point data could be linked to a younger or older age of rotation than what is estimated for the sample. However, temporal age ranges associated with geological data (e.g. fossil occurrence data) are regularly only resolved to the stratigraphic stage level. 
**<--- Could something about model resolution be important to mention here? --->**

## Code availability
All Python code used to generate the reconstruction files are available as Jupyter Notebooks in the [Zenodo]() repository. All analyses were performed in Python ver. XXX (REF) with pyGPlates ver. XXX (REF). We also provide two example scripts (in Python and R) for spatiotemporally linking point data (i.e. coordinates) to their reconstructed coordinates (i.e. palaeocoordinates) in the [Zenodo]() repository.

## References

## Acknowledgements

We are grateful to all those who have contributed to and openly shared Global Plate Models with the community. L.A.J. was supported by a Juan de la Cierva-formación 2021 fellowship (FJC2021-046695-I) funded by MCIN/AEI/10.13039/501100011033 and the European Union NextGenerationEU/PRTR. M.M.D was supported by a....


