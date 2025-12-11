# AI-Driven Closed-Loop Neuromodulation via Integrated Spinal and Vagus Nerve Stimulation

**Real-Time Motor Control Regulation and Recovery**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Author

**Vighnesh Sairaman**
MS. Biomedical Engineering
Viterbi School of Engineering
University of Southern California
Los Angeles, CA, USA
sairaman@usc.edu

---

## Abstract

Neuromodulation therapies such as Spinal Cord Stimulation (SCS) and Vagus Nerve Stimulation (VNS) have emerged as pivotal interventions for restoring motor function and modulating cortical activity. Despite their clinical adoption, most current systems operate in an open-loop fashion, lacking dynamic feedback integration and adaptive control.

We propose a novel, **AI-powered, closed-loop neuromodulation system** that integrates SCS and VNS through deep reinforcement learning, specifically **Proximal Policy Optimization (PPO)**. This system uses biosignals from EEG, EMG, and IMU sensors to optimize stimulation parameters in real-time. It addresses limitations of traditional heuristic-based algorithms by providing robust adaptability, noise tolerance, and personalized therapy optimization.

The system outperforms conventional approaches such as TOKEDA in accuracy, latency, energy efficiency, and false positive rate, and demonstrates strong potential for clinical translation.

---

## Key Features

- **Closed-Loop Control**: Real-time adaptive stimulation based on biosignal feedback
- **Multi-Modal Fusion**: Integrates EEG, EMG, and IMU sensor data
- **Deep Reinforcement Learning**: Uses PPO for optimal policy learning
- **Dual Neuromodulation**: Combines VNS and SCS in a unified control system
- **Energy Efficient**: Optimizes stimulation energy through reward-based learning

---

## System Architecture

The proposed system comprises six major modules forming a closed-loop neuromodulatory control pipeline:

### 1. Multimodal Biosignal Acquisition
- **EEG**: Alpha/beta bands for cortical state monitoring
- **EMG**: Muscle activity detection
- **IMU**: Motion kinematics tracking
- Devices: OpenBCI, EMOTIV, surface electrodes

### 2. Signal Preprocessing
| Signal | Processing Pipeline |
|--------|---------------------|
| EEG | Bandpass filtering → FFT → Power Spectral Density |
| EMG | Rectification → TKEO → RMS envelope extraction |
| IMU | Derivative calculation for velocity/acceleration |

### 3. Feature Encoding
- **1D CNN**: Short-range temporal abstraction
- **Bidirectional LSTM**: Long-term dependency modeling
- Output: Latent feature state vector s_t ∈ R^128

### 4. PPO Policy Network
- **Actor Network**: Outputs continuous-valued stimulation parameters
- **Critic Network**: Estimates value of current biosignal state
- Online training driven by reward feedback

### 5. Neuromodulatory Output
- **VNS Stimulator**: Modulates cortical activity via adjustable pulse trains
- **SCS Stimulator**: Recruits spinal motor circuits using segmental stimulation
- Safety controller for energy, current, and thermal limits

### 6. Reward Feedback Loop
```
R_t = +1.0  (correct step detected)
    = -0.5  (false positive generated)
    = -0.1 × E_t  (energy penalty)
```

---

## Mathematical Formulations

### TKEO-Enhanced EMG
```
Ψ[x(t)] = x²(t) - x(t-1) · x(t+1)
```

### PPO Clipped Objective
```
L^CLIP(θ) = E_t[min(r_t(θ)Â_t, clip(r_t(θ), 1-ε, 1+ε)Â_t)]
```

### Energy Estimation
```
E_t = I² · R · t_pulse
```

---

## Performance Results

### Comparative Evaluation: TOKEDA vs PPO-Based System

| Attribute | TOKEDA | PPO-Based |
|-----------|--------|-----------|
| Adaptability | No | Yes |
| Noise Tolerance | Low | High |
| Learning | None | Online |
| Modality Fusion | EMG only | EEG + EMG + IMU |
| False Positive Rate | 6% | 1.5% |
| Energy Efficiency | Fixed | Optimized |

### Performance Metrics (50 Trials)

| Metric | TOKEDA | PPO |
|--------|--------|-----|
| Accuracy (%) | 82 | **94** |
| Latency (ms) | 180 | **80** |
| False Positives (%) | 6 | **1.5** |
| Energy/Step (μJ) | 100 | **63** |

---

## Repository Structure

```
AI-Closed-Loop-Neuromodulation/
├── README.md
├── LICENSE
├── .gitignore
├── docs/
│   └── AI-Driven-Closed-Loop-Neuromodulation.pdf
├── references/
│   ├── paralysis/
│   │   ├── lower-body-thoracic/
│   │   └── upper-body-spinal/
│   └── tourette/
│       └── osf-archive/
└── data/
```

---

## Applications

- **Spinal Cord Injury (SCI)**: Restoring motor function in paralysis patients
- **Tourette Syndrome**: Suppressing hyperkinetic tics via cortical modulation
- **Parkinson's Disease**: Adaptive tremor control
- **Neurorehabilitation**: Personalized therapy optimization

---

## Future Work

- Validation on hybrid synthetic-biological datasets
- Transfer learning across diverse patient profiles
- Embedded system deployment with real-time operating systems
- Clinical trials for regulatory approval

---

## References

1. Moritz et al., "TOKEDA Algorithm for Step Detection in SCI," *Frontiers*, 2020.
2. Dyke et al., "EEG-Driven VNS in Tourette Syndrome," *OSF Archive*, 2022.
3. Schulman et al., "Proximal Policy Optimization Algorithms," arXiv:1707.06347, 2017.
4. Engineer et al., "Targeted Vagus Nerve Stimulation for Neuromodulation," *Nature Biotech*, 2021.
5. Capogrosso et al., "Spinal Cord Stimulation Restores Motor Function After Paralysis," *Nature*, 2018.

*See full paper for complete references.*

---

## Citation

If you use this work in your research, please cite:

```bibtex
@article{sairaman2025neuromodulation,
  title={AI-Driven Closed-Loop Neuromodulation via Integrated Spinal and Vagus Nerve Stimulation for Real-Time Motor Control Regulation and Recovery},
  author={Sairaman, Vighnesh},
  journal={University of Southern California},
  year={2025}
}
```

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Contact

**Vighnesh Sairaman**
Email: sairaman@usc.edu
University of Southern California, Viterbi School of Engineering
