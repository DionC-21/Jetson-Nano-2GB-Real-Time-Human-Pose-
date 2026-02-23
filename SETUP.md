# Setup Guide (Jetson Nano)

This guide is written for JetPack 4.x / L4T R32.x (Ubuntu 18.04, Python 3.6).

---

## 1) Terminal: System packages

```bash
sudo apt update
sudo apt install -y \
  python3-pip python3-dev \
  git cmake \
  v4l-utils \
  libjpeg-dev \
  libopenblas-dev \
  gstreamer1.0-tools \
  gstreamer1.0-plugins-base \
  gstreamer1.0-plugins-good \
  gstreamer1.0-plugins-bad \
  gstreamer1.0-plugins-ugly
```

Optional but helpful (faster builds / fewer headaches):
```bash
sudo apt install -y ninja-build
```

## 2) Terminal: Python packages

```bash
sudo -H python3 -m pip install --upgrade pip
sudo -H python3 -m pip install \
  notebook==6.4.10 \
  ipywidgets==7.7.2 \
  pillow \
  tqdm
```

Enable widgets (fixes widget errors):
```bash
mkdir -p ~/.jupyter
jupyter nbextension enable --py widgetsnbextension --user
```

## 3) Terminal: Install jetcam

```bash
sudo -H python3 -m pip install git+https://github.com/NVIDIA-AI-IOT/jetcam
```

## 4) Terminal: Install trt_pose

If you already have trt_pose installed from upstream, you can skip this.
This repo assumes trt_pose is installed and importable.

```bash
cd ~
git clone https://github.com/NVIDIA-AI-IOT/trt_pose
cd trt_pose
export OPENBLAS_CORETYPE=ARMV8
export MAX_JOBS=1
sudo -E python3 setup.py install
```

Verify:
```bash
python3 -c "import trt_pose; print('trt_pose ok')"
```

## 5) Download model weights + json into the notebook folder

Go into this repo's notebook folder:
```bash
cd <YOUR_REPO>/notebooks
```

Download human_pose.json from upstream if you don't have it already:
```bash
wget -O human_pose.json https://raw.githubusercontent.com/NVIDIA-AI-IOT/trt_pose/master/tasks/human_pose/human_pose.json
```

Download weights (from the v0.0.1 release):
```bash
wget -O resnet18_baseline_att_224x224_A_epoch_249.pth \
  https://github.com/NVIDIA-AI-IOT/trt_pose/releases/download/v0.0.1/resnet18_baseline_att_224x224_A_epoch_249.pth
```

## 6) Run Jupyter

```bash
cd <YOUR_REPO>
bash scripts/run_jupyter.sh
```

Open the notebook:
`notebooks/live_demo_cpu_stable.ipynb`
