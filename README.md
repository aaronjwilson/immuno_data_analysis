# Immunology Data Analysis

Full disclosure that I am a biased scientist in that I prefer the granularity of data offereings from Flow Cytometry or single-cell RNASeq. This is not a disparagement of other methodologies but most assays (ELISpot, ELISA, MSD, Luminex, Sequencing) are generally averages over a population. Analytically, I am fascinated by three areas of complexity: <br>
1. the artform of non-Graphpadingly deriving logisitic curve fits for end point titers using a programming language.<br>
2. Flow cytometry: with boolean gating being such an unforgettful mind mess
3. the implementation of the alphabet soup that are the dimensionality reduction platforms (PCA, t/v-sne, UMAP, OPLS)  


# 1. More than I wanted to know about curves: ELISA Endpoint Titer Derivation

Interestingly shaped curves in the biosciences can be analyzed a number of ways and often go by the terms: dose reponse curve (DRC), receiver operator curves (ROC), area under curve (AUC). The nonlinearity of the curves generated in an ELISA assay need all of parts of the curve to represent the different parts of the interpolation equations. Logistic regression and the symmetry of the biological data determines whether to use a parameterized (3,4,5) fit.  Graphpad Prism, while a ubiquitous and amazing program for many of our curve fitting concerns, tends towards the onerous as the data load and dimensionality increases. The need for data intensity tools begin to show applicability with to move toward a programmatic languages. Here the R programming language lends itself quite well with defined packages for the generation of elegant graphics (tidyverse) for the ELISpot assay to the more difficult aspects of curve fitting be they derived in an ELISA or some other methodology that creates nonlinear point classifications (MSD, Luminex, Titrations, Flow Cytometry).

With that we can explore the journey towards interpolated endpoints in the [ELISA data analysis portion readme](https://github.com/aaronjwilson/immuno_data_analysis/blob/master/ELISA_DRC.md)

# 2. How can you use pestle and spice if you do not have a mac?

I still remember the day that the boolean gating in flowjo clicked for me and revealed the complexity of the immunological system (that still ceases to fascinate me) and more importantly the power of the flow cytometry methodology. Hats off to [Mario Roederer](https://www.drmr.com/) for spearheading and popularizing the incorporation of multifunctionality into the analytical zeitgeist of the late aughts. My own research foray into a TB mRNA vaccine showed the importance of a polyfunctional CD4 and CD8 cell in the efficacy of the treatment as revealed in the efficacy data. But limited funding and the needs of an IT department to be exclusively Windows for the bench scientists posed a problem when running analytical readouts from flow cytometry data.  FlowJo is partially agnostic to platform (Mac/PC: where is the linux port BD?). This is a means to an end to use R to analyze the data in a SPICE/PESTLE format. 

Flow Cytometry explorations happen here. [ICS boolean data analysis portion readme](https://github.com/aaronjwilson/immuno_data_analysis/blob/master/ICS_TB.md)

# 3. dimensional reduction of alphabet soup.

# 4. Sundries: explorations of analysis of elispot or phenotypic flow cytometry data <br>

[Elispot](https://github.com/aaronjwilson/immuno_data_analysis/blob/master/elispot.md) <br>
[Phenotype](https://github.com/aaronjwilson/immuno_data_analysis/blob/master/Trucount.R) <br>



# Notes on the Data used

The basic data layout will be from .tsv files that have 

1. Categorical Data:
  * participantId - sample identifier
  * groupId - cohort identifier
  * visitId - time point identifier
2. [ELISA Numerical Data](https://github.com/aaronjwilson/immuno_data_analysis/blob/master/data/elisa.tsv)
  * t100 - t409600 - Titration values. R cannot have a number as a header label so they are marked with a t.
3. [ELISpot Numerical Data](https://github.com/aaronjwilson/immuno_data_analysis/blob/master/data/elispot.tsv)
  * generic hiv nomenclature for peptides.  The assay was run with replicates and env has two groupings represented as env1 and env2
 
# Outcomes 

I hope to show for ELISA analysis of dose response by two R packages.  I will also include area under the curve calculations. Both with graphical output.

I hope to show for ELISpot analysis a means of munging the data into a maleable form for the application of aggregating methodologies.  Also with graphical output.  

