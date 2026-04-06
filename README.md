**Code repository for the RIA Center pilot project**

*Examine birth outcomes before and after state-level MCLs for PFAS*

This project develops reproducible, data-driven workflows to analyze the effects of hurricanes on private well contamination and associated health risks. We use public datasets, electronic health records, and geospatial and econometric methods in R.

------------------------------------------------------------------------

## 📁 Project structure

``` text
pfas-mcl-RIA/
├── pfas-mcl-RIA.Rproj   # RStudio project file
├── README.md             # Project documentation
├── renv.lock             # Records the exact versions of R and R packages to ensure reproducibility
├── renv/                 # Directory containing renv infrastructure for the project
├── data/                 # Directory containing input and output data, do not commit to git
    ├──processed_data/    # Sub-folder with processed and analytical datasets
└── script/               # Main analysis scripts
```

## 🚀 Getting started with renv

This project uses renv to manage R package dependencies, ensuring reproducibility. Here's how to get started:

Clone the Repository:

``` text
git clone https://github.com/water-health-opportunity-lab/pfas-mcl-RIA # Replace with the actual URL
cd pfas-mcl-RIA
```

Open the Project in RStudio: Open the pfas-mcl-RIA.Rproj file in RStudio. This will automatically activate the renv environment. Restore Package Library: Run the following command in the R console to install the correct package versions:

``` text
renv::restore()
```

This will install the exact package versions specified in the renv.lock file. Confirm Confirm that the packages have been installed by running:

``` text
renv::status()
```

This will show you the status of the packages in your project. Work in the Project: You're now ready to work in the project! Any packages you install will be managed by renv.

## 🔧 Requirements

This project uses R. To begin, open hurricane-AGI.Rproj in RStudio and run scripts in the script/ folder in order.

## 🔐 API Keys

Store your API keys (e.g., Census API) in an .Renviron file in your home directory:

``` text
CENSUS_API_KEY=your_key_here
```

Do not commit your `.Renviron` file to Git.

## 🚧 Branching Guidelines

This project uses the Git Flow workflow. Please follow these conventions when contributing:

Start from the develop branch:

``` text
git checkout develop
git pull origin develop
```

Create a new feature branch using the feat/ prefix:

``` text
git checkout -b feat/short-description
```

Push your feature branch to GitHub:

``` text
git push -u origin feat/short-description
```

Submit a pull request from your feature branch into develop. Tag @jahredwithanh for review.

## 📌 Project Status

This project is in active development under the REACH Center pilot grant.
