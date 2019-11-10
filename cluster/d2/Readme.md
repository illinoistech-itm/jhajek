# Usage

## Install and Configure Detectron

These are the instructions to install Detectron2 on multiple platforms

### ARM based Nvidia Jetson

1. Using jetpack 4.22 install all of the optional libraries (but not the OS), this includes opencv 3.3.x and protobuf 3.x.x
2. Going to the detectron2 site you can follow their install instructions 

### x86 Ubuntu 18.04


### Script for running against on disk images or mp4

```python3 annotations-load.py --input /home/controller/people/*.jpg --output /directory/to/save/the/image/detections```

--input is the directory of images to render.  This can be a space seperated list or use a wildcard

#### Optional outputs
--output is optional for writing the object recognition blocks to a file
--confidence-threshold is set to 0.5 by default, this can be raised to exclude objects that have a certainty score less than this value

### Script to run to receive streaming video

```python3 annotations-load-viewer.py```

#### Optional Streaming Outputs
`--debug` defaults to `False`. Change to `True` to get Detectron to display the image that the voice is describing. This slows processing down, but is good for debugging. 
`--confidence-threshold` is set to 0.5 by default, this can be raised to exclude objects that have a certainty score less than this value

### Script to Stream Video to Detectron - streamerx.py

```python3 streamerx.py --ip 172.16.1.78 --count 2```

`--ip` is the IP address to stream to
`--count` is how many images to send, default is 5
`--height` set the image height to be sent, default is 800
`--width` set the image width, default to be 600
