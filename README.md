# Pressure profile code 

This is [Henrik Str&ouml;m's](https://www.chalmers.se/en/staff/Pages/henrik-strom.aspx) pressure drop code, which I have modified to accommodate new reactor geometries. 

## Contents

This folder and its sub-folders contain the following scripts:
1. evaluatePressure/RUN_obtainMassFlowRate.m
2. evaluatePressure/functions/compute_mprickij.m
3. evaluatePressure/functions/getGeometry.m
4. evaluatePressure/functions/getKnudsen.m
5. evaluatePressure/functions/getViscosity.m
6. evaluatePressure/functions/massFlowRate.m
7. evaluatePressure/functions/myCAR.m
8. evaluatePressure/functions/P_tilde.m
9. evaluatePressure/functions/plotAndWritePressures.m
10. plotPressureComparison/plotWellmixedVsPFRlike.m
11. evaluatePressure/functions/reorder.m
12. evaluatePressure/functions/setPressures.m
13. evaluatePressure/functions/pathbetweennodes-pkg-master

## Running simulations

Pressure profiles are computed by running the script RUN_obtainMassFlowRate (file 1). 

The geometry is defined in the function getGeometry (file 3), which takes a single argument that should provide an existing reactor type. Current series options are wellmixed and pfrlike (see exampleSystemSegmentation.pdf). Current parallel options are parallel_1-3 (see exampleParallelChannelsAndNotes.pdf). New options with different length/width/height segments can be set up here. The channel system is divided into straight duct segments across which the length, width and height are constant. The connectivity between segment must be specified in the same order as the dimensions. Graph tools are used to accommodate parallel channels.  

The upstream (Pin) and downstream pressures (Pout) are known boundary conditions. The intermediate pressures and mass flow rate are unknowns. The code computes the pressure drop across each segment by solving for a consistent steady state mass flow rate (files 2, 6, 7) and then establishes the pressure profile between each junction (8). It uses expressions from Beskok and Karniadakis [1] (a copy of which is saved in this folder). 

## Plotting results

Files 9-10 plot the pressure profiles from a single simulation and comparing the well-mixed and pfr-like cases respectively. 

File 9 also stores the calculated pressure profiles in the data folder. 

[1] Beskok, A., Karniadakis, G. E., 1999, A Model for Flows in Channels, Pipes, and Ducts At Micro and Nano Scales, Microscale Thermophysical Engineering, 3:43-77. 

## External dependencies

The paths in the graph are computed using the pathbetweennodes code (item 13) developed by Kelly Kearney and distributed on GitHub [here](https://github.com/kakearney/pathbetweennodes-pkg). It is included in the functions directory. 

---

Astrid Boje, 4 December 2020.
[![DOI](https://zenodo.org/badge/273471317.svg)](https://zenodo.org/badge/latestdoi/273471317)

