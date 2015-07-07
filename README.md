# Immunology Data Analysis

Use of standard techniques in immunology include the assays ELISA and ELISpot.  Whereas ELISpot has a relatively simple analysis flow chart, ELISA poses a different methodology with the use of logistic curve fitting.  


# More than I wanted to know about curves

Curves can be analyzed a number of ways and often go by the terms: dose reponse curve (DRC), receiver operator curves (ROC), area under curve (AUC). The curves are not standard in that they are often nonlinear with the midrange of the curve being labeled the C50 as in IC50 or EC50 depending on the assay conditions.  The nonlinearity requires the use of a curve fitting equation called logistic regression and the symmetry of the biological data determines whether to use a 4 parameter or a 5 parameter equation.  Though the formulas are similar 5th parameter is present as an asymmetry factor and can better address curves that are not sigmoidal.  

Here the R programming language lends itself quite well with defined packages for approaching the simple analytics found in the ELISpot assay to the more difficult aspects of curve fitting be they derived in an ELISA or some other methodology that creates nonlinear point classifications (MSD, Luminex, Titrations, Flow Cytometry).


# Notes on the Data used

The basic data layout will be from .tsv files that have 

1. Categorical Data:
  * participantId - sample identifier
  * groupId - cohort identifier
  * visitId - time point identifier
2. ELISA Numerical Data
  * t100 - t409600 - Titration values. R cannot have a number as a header label so they are marked with a t.
3. ELISpot Numerical Data
  * generic hiv nomenclature for peptides.  The assay was run with replicates and env has two groupings represented as env1 and env2
 
# Outcomes 

I hope to show for ELISA analysis of dose response by two R packages.  I will also include area under the curve calculations. Both with graphical output.

I hope to show for ELISpot analysis a means of munging the data into a maleable form for the application of aggregating methodologies.  Also with graphical output.  

