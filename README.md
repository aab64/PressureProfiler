# Pressure profile code 

This is Henrik Str&ouml;m's original pressure drop code, which I have modified to accommodate new reactor geometries. 

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

## Running simulations

Pressure profiles are computed by running the script RUN_obtainMassFlowRate (file 1). 

The geometry is defined in the function getGeometry (file 3), which takes a single argument that should provide an existing reactor type. Current options are wellmixed and pfrlike (see exampleSystemSegmentation.pdf). New options with different length/width/height segments can be set up here. The channel system is divided into a series of straight duct segments across which the length, width and height are constant. 

The upstream (Pin) and downstream pressures (Pout) are known boundary conditions. The intermediate pressures and mass flow rate are unknown. The code computes the pressure drop across each segment by solving for a consistent steady state mass flow rate (files 2, 6, 7) and then establishes the pressure profile between each junction (8). It uses expressions from Beskok and Karniadakis [1] (a copy of which is saved in this folder). 

## Plotting results

Files 9-10 plot the pressure profiles from a single simulation and comparing the well-mixed and pfr-like cases respectively. 

File 9 also stores the calculated pressure profiles in the data folder. 

[1] Beskok, A., Karniadakis, G. E., 1999, A Model for Flows in Channels, Pipes, and Ducts At Micro and Nano Scales, Microscale Thermophysical Engineering, 3:43-77. 

---

Astrid Boje, 19 June 2020.