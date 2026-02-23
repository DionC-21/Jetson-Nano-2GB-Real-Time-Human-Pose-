# Jetson Nano Pose Estimation (Stable CPU Demo)

This repo is my **Jetson Nano–stable version** of NVIDIA's `trt_pose` demo.  
My goal was to get a **reliable live camera + pose overlay** working on a Jetson Nano without random freezes.

✅ Works with a standard USB webcam  
✅ Runs continuously in Jupyter Notebook  
✅ Designed to avoid common Jetson Nano issues (CUDA freezes, camera pipeline failures, widget stutter)

---

## Credits / Original Work

This project is based on NVIDIA's open-source repos:

- `trt_pose`: NVIDIA-AI-IOT/trt_pose  
- `torch2trt`: NVIDIA-AI-IOT/torch2trt  
- `jetcam`: NVIDIA-AI-IOT/jetcam

I originally forked from the upstream ecosystem, but made this repo to document **what I changed**, **why it broke on my Nano**, and how I debugged it.

---

## What I changed (in plain English)

On Jetson Nano (JetPack 4.x / L4T R32.x), I ran into:
- CUDA allocation / system freeze during `torch.cuda()` operations
- OpenCV camera failing with default `VideoCapture(0)` due to pipeline mismatch
- Jupyter widget updates causing stutter/freezing

### Fixes I implemented
- **CPU-safe inference mode** (disables CUDA to prevent full system lockups)
- **Explicit GStreamer pipeline** using MJPG (so USB cams reliably initialize)
- **Performance tuning**: frame-skipping for inference + UI update throttling
- **Bigger widget display** while keeping the model input small for speed

---

## Requirements

### Hardware
- NVIDIA Jetson Nano Developer Kit
- USB webcam (UVC compatible)

### Software (recommended)
- JetPack 4.6.x (L4T R32.7.x)
- Python 3.6 (default on JetPack 4.x)

---

## Quick Start (Most People)

### A) Terminal (install deps)
Follow: **SETUP.md**

### B) Jupyter Notebook (run demo)
Open: `notebooks/live_demo_cpu_stable.ipynb`

---

## Run Jupyter (Terminal)

```bash
cd ~
bash scripts/run_jupyter.sh
```

Then open the Jupyter link in your browser and run the notebook.

---

## Where to type commands (important)

**Terminal commands** are shown in bash blocks like:
```bash
sudo apt update
```

**Notebook / Python code** is shown in python blocks like:
```python
import cv2
```

---

## Debugging Help

If your camera doesn't open, if it freezes, or if pose overlay doesn't show, see:

**DEBUGGING.md**

---

## Demo Notes

- This repo focuses on a **stable live demo** first.
- Once your system is stable, you can explore TensorRT / GPU acceleration later.

---

## License / Attribution

This repository includes original upstream work from NVIDIA repos.
See **LICENSE_NOTICE.md** for attribution details.
