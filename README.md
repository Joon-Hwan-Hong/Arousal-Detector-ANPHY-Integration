# Arousal-Detector-ANPHY-Integration

This is a repository for COMP 401 Summer Project at the [ANPHY lab](https://www.mcgill.ca/frauscher-lab/) in McGill Univeristy. SigFI scripts used are not included as AFAIK not a open source distribution.

## Workflow
### 1) Preprocessing.m
Edit filepaths and parameter variables as necessary (desired frequency, filetype, output path, etc.) and run Preprocessing.m
### 2) ar_predict.py
Run the script in an environment with minimum requirment of Python >= 3.6, Python module numpy >= 1.14.0, and Python module tensorflow >= 1.5.0.
### 3) Postprocessing.m
Edit parameter variables as necessary (output file name, original sampling frequency, binerization threshold, label location, etc.) and run Postprocessing.m
### 4) Check .EDF file
Open file  & observed changes to the .STS file
