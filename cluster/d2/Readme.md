# Usage

## Install and Configure Detectron

These are the instructions to install Detectron2 on multiple platforms

### ARM based Nvidia Jetson

1. Using jetpack 4.22 install all of the optional libraries (but not the OS), this includes opencv 3.3.x and protobuf 3.x.x
2. Going to the detectron2 site you can follow their install instructions 

### x86 Ubuntu 18.04


### Run the script

```python3 annotations-load.py /home/controller/people/_DSC0700.JPG /home/controller/```

The first value: `/home/controller/people/_DSC0700.JPG` is the path to the sample image to do object detection on
The second value:  `/home/controller/` is the path to your users home directory (this lets you switch systems)


