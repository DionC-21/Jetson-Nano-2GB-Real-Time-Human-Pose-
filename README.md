# Jetson-Nano-2GB-Real-Time-Human-Pose-
This project runs real-time human pose estimation on a Jetson Nano using a USB webcam.   The original NVIDIA trt_pose demo was unstable on my Nano due to CUDA allocation freezes, GStreamer pipeline failures, and memory constraints. I redesigned the demo to run reliably on CPU with performance tuning for embedded hardware.
