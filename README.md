# Immunology Data Analysis
Use of standard techniques in immunology include the assays ELISA and ELISpot.  Whereas ELISpot has a relatively simple analysis flow chart, ELISA poses a different methodology with the use of logistic curve fitting.  

Curves can be analyzed a number of ways and often go by the terms: dose reponse curve (DRC), receiver operator curves (ROC), area under curve (AUC). The curves are not standard in that they are often nonlinear with the midrange of the curve being labeled the C50 as in IC50 or EC50 depending on the assay conditions.  The nonlinearity requires the use of a curve fitting equation called logistic regression and the symmetry of the biological data determines whether to use a 4 parameter or a 5 parameter equation.  Though the formulas are similar 5th parameter is present as an asymmetry factor and can better address curves that are not sigmoidal.  

Here the R programming language lends itself quite well with defined packages for approaching the simple analytics found in the ELISpot assay to the more difficult aspects of curve fitting be they derived in an ELISA or some other methodology that creates nonlinear point classifications (MSD, Luminex, Titrations, Flow Cytometry).

The basic data layout will be from .tsv files that have 
1. categorical data: 
``* ParticipantID
``* GroupID

2. numerical data: titrations from T100 to T409600
