# CarModel

Historical MATLAB traffic-model simulations from the 2014 COMAP Mathematical Contest in Modeling work that later informed the paper ["Agent-Based Implementation of Particle Hopping Traffic Model With Stochastic and Queuing Elements"](https://arxiv.org/abs/1803.09206).

This repository is intentionally archived as a research artifact. It is useful as a compact record of an early agent-based traffic-modeling project, not as an actively maintained software package.

## Research context

The underlying work studies multi-lane traffic flow with:

- stochastic driver behavior
- passing conventions such as right-except-to-pass
- lane-change rules
- vehicle heterogeneity
- accident and congestion perturbations

The arXiv paper reports that right-except-to-pass rules increase sustainable critical density, lane count raises supported density, and automated driving assumptions materially improve system throughput.

## What is in the repo

The codebase consists of MATLAB scripts for running and plotting traffic simulations under different assumptions.

| File | Purpose |
|---|---|
| `TwoLanecomp6Dens2.m` | Two-lane simulation sweep across densities with flow and velocity plots |
| `AsymmMultilaneCP.m` | Multi-lane simulation with passing behavior, heterogeneous drivers, and flow tracking |
| `CarPlots.m` | Representative vehicle-position plotting for asymmetric lane behavior |
| `CarPlotsSymm.m` | Symmetric-lane plotting variant |
| `AsymmMultilane.m` | Earlier asymmetric multi-lane simulation variant |
| `AsymmMultilaneCarPlots.m` | Additional plotting workflow for asymmetric runs |

## How to run

Open the scripts in MATLAB or GNU Octave-compatible tooling and run them directly.

Most scripts define their own parameters near the top, including:

- `density`
- `numlanes`
- `gridpts`
- `vmax`
- `badDriverp`
- `passfactor`

Outputs are primarily figures showing vehicle trajectories, average velocity, and flow across different densities.

## Why keep this public

This repo preserves the simulation logic behind the paper and keeps the modeling assumptions inspectable. Even as a compact historical codebase, it captures the mechanics of lane rules, stochastic driver behavior, and throughput analysis directly in runnable scripts.

## Archived status

`CarModel` is preserved for historical and publication context. It should be read as an archived research code artifact rather than an actively maintained software project.

## Citation

```bibtex
@article{champion2018traffic,
  title={Agent-Based Implementation of Particle Hopping Traffic Model With Stochastic and Queuing Elements},
  author={Champion, Camilla and Champion, Cody},
  journal={arXiv preprint arXiv:1803.09206},
  year={2018}
}
```
