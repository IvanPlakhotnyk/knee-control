# BEng Final Project

This is private repository for the **EVENT DETECTION FOR POWERED
LIMB PROTHESIS** project. This README file contains important information.

### Aims and objectives.

![alt text](pictures/higest-level-controller.png)

The aim of the project is to **develop a system capable of real-time gait event detection for powered limb prostheses using ligament stretch and sEMG data**.
Objectives:
- Data Collection: Collect and preprocess ligament stretch, sEMG and Motion Capture data to establish a structured dataset for analysis.
- Offline Data Analysis: Identify recurring patterns between LVDT signals, sEMG activity, and gait events through offline data processing.
- Online Data Processing: Develop and validate a MATLAB-based algorithm for real-time gait event detection.

1. Complete dataset was obtained. The rig for data collection is a modified version of **?device?**. The bicondylar knee joint[ref] is installed between the knee bed(is it a thing?) and the crutch. Two compliant ligaments are represented by springs. Their stretch is measured with LVDTs (Solartron SM3) and recorded to the NI DAQ. sEMG was also recorded but with Delsys Station.
eSync2 syncronisation used to syncronise LVDT and sEMG data. 
The trial required a person to walk on a treadmill for about a minute wit.

### How to use me?

- Easy raw data formatting
    
      1. Save files as mocap.csv, daq.csv, emg.csv.
      2. Add files from PATH folder into your MATLAB userpath folder. Note: to see your matlab userpath use 'userpath'.
      3. Run formatData on the files from Motive. (Do not change anything in the files)
      4. Identify the heel strikes using 'findPeaks' command.
      5. Use heel strikes to break the data into steps using 'segmentData'.

Note: to be automatised.

- Data Visualisation

      showTrial(trial, trialNumbers) to open an interactive plot and use arrow keys to switch between them.