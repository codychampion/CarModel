# CarModel

![Status](https://img.shields.io/badge/status-archived-64748b)
![MATLAB](https://img.shields.io/badge/MATLAB-simulation-0076a8)
![arXiv](https://img.shields.io/badge/arXiv-1803.09206-b31b1b)
![Domain](https://img.shields.io/badge/domain-agent--based%20traffic%20modeling-2f6f4e)

Historical MATLAB simulations for the 2014 COMAP Mathematical Contest in Modeling work later released as the arXiv paper ["Agent-Based Implementation of Particle Hopping Traffic Model With Stochastic and Queuing Elements"](https://arxiv.org/abs/1803.09206).

This is an archived research-code repository. It is useful as a compact, inspectable record of an early agent-based traffic simulation project, not as an actively maintained software package.

## Paper context

The paper studies microscopic traffic flow using an agent-based particle-hopping model built from cellular-automata ideas. Instead of treating traffic as a continuous fluid, the model represents individual vehicles moving through a discrete lane-by-position lattice.

The modeling questions were:

- how right-except-to-pass rules affect sustainable traffic density
- how lane count changes the density a road can support before global jams appear
- how stochastic human behavior changes flow compared with automated assumptions
- how accidents perturb otherwise stable traffic systems
- which driver maximum-speed distributions produce efficient flow

The arXiv record lists the paper under Cellular Automata and Lattice Gases (`nlin.CG`) and Applications (`stat.AP`), submitted on March 25, 2018, with the note that it originated from the 2014 COMAP Mathematical Contest in Modeling.

## Reported findings

The paper reports several high-level results that explain why these scripts exist:

- right-except-to-pass behavior increases the critical density the simulated road can support
- removing stochastic human factors, as a proxy for automation, produces a 160% increase in sustainable critical density
- adding lanes increases supported critical density, while the most efficient speed-distribution shape remains stable
- excluding full automation, the best tested maximum-speed distribution was `Beta(5,5)`
- accidents in stable systems can create local jams without necessarily triggering global jams

## Model structure

The scripts model traffic as vehicles moving across a discrete grid. A simulation typically defines:

| Variable | Meaning |
|---|---|
| `numlanes` | Number of lanes in the road lattice |
| `gridpts` | Number of positions along the road |
| `density` | Vehicle density used to compute `numcars` |
| `vmax` | Maximum allowed velocity or speed-distribution scale |
| `badDriverp` | Probability of random driver slowdown |
| `passfactor` | Probability that a driver attempts to pass when permitted |

Each vehicle is tracked through a `carChar` matrix. In the more complete scripts, its columns represent:

| Column | Meaning |
|---|---|
| 1 | Starting position |
| 2 | Ending position |
| 3 | Current velocity |
| 4 | Current lane |
| 5 | Ending lane |
| 6 | Vehicle type, with cars and trucks represented separately |
| 7 | Rank or lane-change direction, depending on script variant |
| 8 | Rudeness / passing probability factor |
| 9 | Personalized maximum speed |

## Repository contents

| File | Purpose |
|---|---|
| `TwoLanecomp6Dens2.m` | Two-lane density sweep used for flow and velocity comparisons |
| `AsymmMultilaneCP.m` | Multi-lane particle-hopping model with heterogeneous vehicles, passing behavior, and queuing logic |
| `AsymmMultilane.m` | Earlier asymmetric multi-lane simulation variant |
| `CarPlots.m` | Representative vehicle-position plots for asymmetric two-lane behavior |
| `CarPlotsSymm.m` | Symmetric-lane plotting variant |
| `AsymmMultilaneCarPlots.m` | Additional plotting workflow for asymmetric runs |
| `TwoLanecomp6Dens2.asv` | MATLAB autosave retained for historical completeness |

## How to run

Open the scripts in MATLAB and run them directly. GNU Octave may work for some scripts, but several workflows use MATLAB functions such as `randsample` and `betarnd`, which are commonly provided through MATLAB's Statistics and Machine Learning Toolbox.

Most scripts define their experiment parameters near the top. The primary outputs are figures for:

- vehicle position over time
- average velocity
- flow as density changes
- qualitative congestion patterns

## Historical status

This repository preserves the code behind an early research-modeling project. Some scripts are exploratory, some parameters are embedded directly in source files, and the code reflects contest-paper experimentation rather than production software engineering.

The value of keeping it public is provenance: the traffic-modeling assumptions, agent state, stochastic behavior, and plotting workflows remain visible alongside the paper.

## Citation

```bibtex
@article{champion2018traffic,
  title={Agent-Based Implementation of Particle Hopping Traffic Model With Stochastic and Queuing Elements},
  author={Champion, Camilla and Champion, Cody},
  journal={arXiv preprint arXiv:1803.09206},
  year={2018},
  doi={10.48550/arXiv.1803.09206},
  url={https://arxiv.org/abs/1803.09206}
}
```
