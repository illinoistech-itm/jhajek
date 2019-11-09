# You may need to restart your runtime prior to this, to let your installation take effect
# Some basic setup
# Setup detectron2 logger
import detectron2
from detectron2.utils.logger import setup_logger
setup_logger()

# import some common libraries
import numpy as np
import cv2
import sys
import glob
import torch
import pyttsx3
import argparse
import os
import time
import tqdm
import multiprocessing as mp

# import some common detectron2 utilities
from detectron2.engine import DefaultPredictor
from detectron2.config import get_cfg
from detectron2.utils.visualizer import Visualizer
from detectron2.data import MetadataCatalog
# https://www.geeksforgeeks.org/python-count-occurrences-element-list/
from collections import Counter 

def setup_cfg(args):
    # load config from file and command-line arguments
    cfg = get_cfg()
    cfg.merge_from_file(args.config_file)
    cfg.merge_from_list(args.opts)
    # Set score_threshold for builtin models
    cfg.MODEL.RETINANET.SCORE_THRESH_TEST = args.confidence_threshold
    cfg.MODEL.ROI_HEADS.SCORE_THRESH_TEST = args.confidence_threshold
    cfg.MODEL.PANOPTIC_FPN.COMBINE.INSTANCES_CONFIDENCE_THRESH = args.confidence_threshold
    cfg.freeze()
    return cfg


def get_parser():
    parser = argparse.ArgumentParser(description="Detectron2 Demo")
    parser.add_argument("--input", nargs="+", help="A list of space separated input images")
    parser.add_argument("--output", help="A file or directory to save output visualizations. " "If not given, will show output in an OpenCV window.",)
    parser.add_argument("--video-input", help="Path to video file.")
    parser.add_argument(
        "--confidence-threshold",
        type=float,
        default=0.5,
        help="Minimum score for instance predictions to be shown",
    )
    return parser

if __name__ == "__main__":
    WINDOW_NAME = "COCO detections"

    #command prompts values
    cfgin=os.environ['HOME'] + "/detectron2/configs/COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x.yaml"
    engine = pyttsx3.init() # object creation

    """ RATE"""
    rate = engine.getProperty('rate')   # getting details of current speaking rate
    print (rate)                        #printing current voice rate
    engine.setProperty('rate', 175)     # setting up new voice rate

    # COCO dataset categories
    dataset=['person', 'bicycle', 'car', 'motorcycle', 'airplane', 'bus', 'train', 'truck', 'boat', 'traffic light', 'fire hydrant', 'stop sign', 'parking meter', 'bench', 'bird', 'cat', 'dog', 'horse', 'sheep', 'cow', 'elephant', 'bear', 'zebra', 'giraffe', 'backpack', 'umbrella', 'handbag', 'tie', 'suitcase', 'frisbee', 'skis', 'snowboard', 'sports ball', 'kite', 'baseball bat', 'baseball glove', 'skateboard', 'surfboard', 'tennis racket', 'bottle', 'wine glass', 'cup', 'fork', 'knife', 'spoon', 'bowl', 'banana', 'apple', 'sandwich', 'orange', 'broccoli', 'carrot', 'hot dog', 'pizza', 'donut', 'cake', 'chair', 'couch', 'potted plant', 'bed', 'dining table', 'toilet', 'tv', 'laptop', 'mouse', 'remote', 'keyboard', 'cell phone', 'microwave', 'oven', 'toaster', 'sink', 'refrigerator', 'book', 'clock', 'vase', 'scissors', 'teddy bear', 'hair drier', 'toothbrush']
    mp.set_start_method("spawn", force=True)
    args = get_parser().parse_args()
    logger = setup_logger()
    logger.info("Arguments: " + str(args))
    #cfg = setup_cfg(args)

    cfg = get_cfg()
    cfg.merge_from_file(cfgin)
    cfg.MODEL.ROI_HEADS.SCORE_THRESH_TEST = 0.5  # set threshold for this model
    # Find a model from detectron2's model zoo. You can either use the https://dl.fbaipublicfiles.... url, or use the following shorthand
    cfg.MODEL.WEIGHTS = "detectron2://COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x/137849600/model_final_f10217.pkl"

    if args.input:
        if len(args.input) == 1:
            args.input = glob.glob(os.path.expanduser(args.input[0]))
            assert args.input, "The input path(s) was not found"
        for path in tqdm.tqdm(args.input, disable=not args.output):
            # read image
            start_time = time.time()
            im = cv2.imread(path)
            #cv2.imshow('display',im)
            #print("image display loaded")
            #https://stackoverflow.com/questions/22274789/cv2-imshow-function-is-opening-a-window-that-always-says-not-responding-pyth
            #cv2.waitKey(5000)
            #cv2.destroyAllWindows()
            # do detection

            predictor = DefaultPredictor(cfg)
            outputs = predictor(im)
            print("models loaded")
            logger.info(
                "{}: detected {} instances in {:.2f}s".format(
                    path, len(outputs["instances"]), time.time() - start_time
                )
            )

            # create a list that converts the classes tensor item to a python number so 
            # we can look up what class it is in the dataset list at the top of this program
            clist = []
            # prints out the predictor model
            # look at the outputs. See https://detectron2.readthedocs.io/tutorials/models.html#model-output-format for specification
            #print(outputs["instances"].pred_classes)
            classes=outputs["instances"].pred_classes
            scores=outputs["instances"].scores
            for x in range(len(classes)):
                clist.append(classes[x].item())

            #print(clist)
            # convert list to a set and then back to list to get unique items
            # https://stackoverflow.com/questions/12897374/get-unique-values-from-a-list-in-python
            uclasses=list(set(clist))
            # create a counter of the clist in a dict
            cd = Counter(clist)
            # speak what you see
            print("Speaking what I see...")
            engine.say("I see:")
            for i in range(len(uclasses)):
              engine.say(cd[uclasses[i]])
              engine.say(dataset[uclasses[i]])

            engine.runAndWait()
            engine.stop()

            if args.output:
                if os.path.isdir(args.output):
                    assert os.path.isdir(args.output), args.output
                    out_filename = os.path.join(args.output, os.path.basename(path))
                else:
                    assert len(args.input) == 1, "Please specify a directory with args.output"
                    out_filename = args.output
                    v.save(out_filename)
            else:
                # add visualizations
                # We can use `Visualizer` to draw the predictions on the image.
                v = Visualizer(im[:, :, ::-1], MetadataCatalog.get(cfg.DATASETS.TRAIN[0]), scale=1.2)
                v = v.draw_instance_predictions(outputs["instances"].to("cpu"))
                #cv2.imshow("rendered",v.get_image()[:, :, ::-1])
                #cv2.waitKey(5000)
                #cv2.destroyAllWindows()
 