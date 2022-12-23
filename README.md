# An-Automated-Approach-for-Electric-Network-Frequency-Estimation-in-Static-and-Non-Static-Digital-Video-Recordings
This is a Matlab implementation of "An-Automated-Approach-for-Electric-Network-Frequency-Estimation-in-Static-and-Non-Static-Digital-Video-Recordings" journal paper.

# run main_VIDEO.m

In order to run the framework developed in the proposed work for automated ENF estimation in static and non-static digital video recordings, run the script main_VIDEO.m. Note: main_VIDEO.m takes as input an .mp4 file of the recorded video and a ground truth ENF signal. Its output derives the maximum correlation coefficient between the estimated ENF and the ground truth.

Running the script, Figure 5 of the paper will be reproduced. For this example, a specific .mp4 video and the accompanied ENF ground truth values (GT_ENF variable) are given as input. The code was implemented by employing MATLAB R2016a.

The employed dataset can be downloaded from: https://zenodo.org/record/3549379#.Y6WRPXZByUk
Fernandez-Menduina, S. and Pérez-González, F. "ENF Moving Video Database". 2020.


# Cite
If you find this code useful in your research, please consider citing:
```
@article{karantaidis2021automated,
  title={An Automated Approach for Electric Network Frequency Estimation in Static and Non-Static Digital Video Recordings},
  author={Karantaidis G. and Kotropoulos C.},
  journal={Journal of Imaging},
  volume={7},
  number={10}
  pages={202},
  year={2021},
  publisher={MDPI},
  doi={https://doi.org/10.3390/jimaging7100202}
}
