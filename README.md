# sEMG-ROBOT-ARM
Author: Wang Yinuo\
Date: 2020.05.22\
Contect: dbdxwyn@163.com

## Introduction
This project developed a humanoid sEMG prosthetic hand interactive control system based on machine learning algorithms, which can recognize five common hand gesture actions and control the robot hand to implement the corresponding actions in real time. The system includes functions such as sEMG signal acquisition and processing, recognition and classification, and motion control of the mechanical prosthetic hand. It also has a graphical user interface (GUI) for interactive control. Users can monitor and control the system's operating status through the interface.

The sEMG signal is collected using three-channel surface patch electrodes in 2Khz. Based on the study of the muscle function of the human forearm, the placement of the patch electrodes is selected. The collected signal is transmitted to the host computer through the amplifier and acquisition card PCI-1716, where the signal is pre-processed by Matlab. 9 common sEMG signal time-domain and frequency-domain features are extracted and support vector machine (SVM) is used to construct a multi-classifier for gesture signals. By optimizing key parameters, more than 95% classification accuracy is achieved. The control commands are sent to the Arduino through the serial port to realize the real-time motion control of the prosthetic hand (uHand).\
![图片1](https://user-images.githubusercontent.com/69251304/110206680-297ce580-7eba-11eb-8624-ba36f5478f79.jpg)

## Dataset
getdate-matlab中是采集肌电信号的简单例程, 可以自己构建手势数据集;\
raw.mat为原始数据，已打标签；moni.mat为测试集，未打标签。

There are some simple examples of collecting EMG signals in getdata-matlab directory, and you can use them to build your own hand gesture dataset;\
For the data set, raw.mat is the original data and has been labeled, and moni.mat is the unlabeled test set.

## libsvm3.24
SVM工具箱，使用前存至matlab/toolbox目录下，将libsvm3.24/matlab目录下各函数C文件全部编译为mexw64格式;\
之后调用时文件名即为函数名。

SVM toolbox\
Save it to the path: matlab/toolbox before use;\
Compile all the function C files in the libsvm3.24/matlab directory into mexw64 format;\
The files' name are the functions' name when used.

## ArduinoIO
Matlab 自带的ARDUINO HARDWARE SUPPORT PACKAGE，用于和下位机串口通信，\
使用前要将ArduinoIO/pde/aideos/aidoes.pde用arduino编译器烧录到单片机中，\
首次连接时需要将matlab工作目录选择到该文件夹下。

The ARDUINO HARDWARE SUPPORT PACKAGE that comes with Matlab, which is used to communicate with the serial port of the lowe-level computer.\
Before use, ArduinoIO/pde/aideos/aidoes.pde should be written into the microcontroller with the arduino compiler.
When connecting for the first time, you need to select the matlab working path to this folder.

## Func
自定义函数文件，函数功能介绍详见各函数文件。

Self-defined function.\
For detailed function description, please refer to README.md file in the Func directory.

## Train & Test
其中trainonline.m文件为训练分类器时使用，testonline.m为测试时使用，\
两个文件均不需要连接采集卡和下位机，只用来信号处理。

The trainonline.m is used when training the classifier, and the testonline.m is used when testing.\
These two files are only used for signal processing. You do not need to be connected to the acquisition card or the lowe-level computer.

## GUI
系统通过GUI集成，使用前需要将训练好的模型和归一化准则放至该文件夹中；\
GUI/monitor.m 为系统主程序，集成上述功能。

This robot control system is integrated through the GUI, and the trained model and normalization rules need to be placed in this folder before using;\
GUI/monitor.m is the main program of the system, which integrates the above functions.\
![GUI](https://user-images.githubusercontent.com/69251304/110206875-4d8cf680-7ebb-11eb-8394-9a336c1743f9.gif)

## Plot
图表绘制程序；pre_pic绘制预处理效果；cluster_pic绘制特征聚类图；curve_pic绘制学习曲线，验证曲线。

Chart drawing program\
pre_pic.m draws the pre-processing effect; \
cluster_pic.m draws the characteristic clustering diagram; \
curve_pic.m draws the learning curve and verification curve.

### Supplement
参考文献及图片视频

References & pictures and videos.

