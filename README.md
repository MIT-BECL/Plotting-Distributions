#  Plotting One-variable Distributions
*Compiled by*
Josh Peters, George Sun

*Support by*
Prerna Bhargava, Kyle McLean, Divya Ramamoorthy, Tyler Toth, Alexander Triassi

**Last Updated: 15 December 2018**

---
## Introduction
This repository compiles basic R resources to build plots comparing distributions between one continous variable (e.g. protein concentration) across multiple discrete variables (e.g. samples). This situation is common in the life sciences due to the need to conduct replicates of experiments with multiple positive and negative controls. Additionally, these plots are common when one wants to drill-down to one gene or protein in -omics datasets. Examples include:
1. Protein concentrations across samples from ELISAs
2. Transcript level distributions across samples in bulk RNA-seq or cells in scRNA-seq
3. Bacterial load in cells or tissue post-infection

Data with temporal aspects *can* be displayed with this plots, but the number of time points should be less than 3. Regardless, it is not recommended.

## Getting Started
The files within this repository can be downloaded using the green "clone or download" button above.  
Inside this repository contains:
  - [Cheatsheet PDF for quick viewing](https://github.com/MIT-BECL/Plotting-Distributions/raw/master/distributions_walkthrough.pdf)
  - Associated notebooks and raw data to generate plots within cheatsheets
  - Practice data sets you can use to generate plots and play around with themes of your own. Both the data and original plot are included in the `/data` folder.
    - The included scripts use data from this **[predator-prey publication](https://www.nature.com/articles/nature25479)**.
    - Additional data sets are included from this **[amyloid-beta publication](https://www.nature.com/articles/s41586-018-0790-y)** and this **[PD-1 publication](https://www.nature.com/articles/s41586-018-0756-0)**.

*We do not own this data. All credit goes to the authors for providing this data with publication. Usage of this data is at the discretion of the user.*

Within the notebooks provided, the system and session info are detailed.

## More Resources
Check out our list of resources
- [Data visualization resources](https://github.com/MIT-BECL/awesome-becl-resources#data-visualization-resources)
- [Plotting resources](https://github.com/MIT-BECL/awesome-becl-resources#plotting-tools)
