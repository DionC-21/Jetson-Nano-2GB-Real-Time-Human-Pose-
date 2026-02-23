# Debugging Guide (Jetson Nano)

This page is the "what to try when things break" list.

---

## A) Check JetPack / L4T version

```bash
cat /etc/nv_tegra_release
```

## B) Camera troubleshooting

### 1) Confirm camera exists
```bash
ls -l /dev/video*
```

### 2) Find supported formats
```bash
v4l2-ctl -d /dev/video0 --list-formats-ext
```

If you see MJPG supported, that's ideal.

### 3) Check if something is using the camera
```bash
sudo fuser -v /dev/video0 || true
```

If another process is holding it, close that app or restart Jupyter kernel.

### 4) Quick OpenCV GStreamer test (Terminal)
```bash
python3 - <<'PY'
import cv2
GST = (
    "v4l2src device=/dev/video0 ! "
    "image/jpeg,width=320,height=240,framerate=30/1 ! "
    "jpegdec ! videoconvert ! "
    "video/x-raw,format=BGR ! appsink drop=1 sync=false max-buffers=1"
)
cap = cv2.VideoCapture(GST, cv2.CAP_GSTREAMER)
print("opened:", cap.isOpened())
ret, frame = cap.read()
print("read:", ret, None if frame is None else frame.shape)
cap.release()
PY
```

If `opened: True` and `read: True`, your camera pipeline is working.

## C) If Jupyter is slow/freezing

### 1) Lower display size or UI FPS

In the notebook:
- Reduce `DISPLAY_W, DISPLAY_H` (ex: 480x480)
- Reduce `TARGET_UI_FPS` (ex: 10)

### 2) Reduce inference frequency

Increase `INFER_EVERY` (ex: 4 or 5)

## D) If CUDA operations freeze the Nano

This repo intentionally disables CUDA:
```python
os.environ["CUDA_VISIBLE_DEVICES"] = ""
```

If you re-enable CUDA and it freezes, revert to CPU mode first.

## E) Memory checks

```bash
free -h
```

If you keep hitting low-memory issues:
- close extra apps
- lower UI FPS
- reduce camera resolution
- reboot
