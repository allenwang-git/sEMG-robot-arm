# sEMG-ROBOT-ARM
Author: Wang Yinuo\
Date: 2020.05.22\
Contect: dbdxwyn@163.com\

## 1.Dataset:
数据集，raw.mat为原始数据，已打标签；moni.mat为测试集，未打标签。

For the data set, raw.mat is the original data and has been labeled, and moni.mat is the unlabeled test set.


## 2.libsvm3.24:
SVM工具箱，使用前存至matlab/toolbox目录下，将libsvm3.24/matlab目录下各函数C文件全部编译为mexw64格式;\
之后调用时文件名即为函数名。

SVM toolbox\
Save it to the path: matlab/toolbox before use;\
Compile all the function C files in the libsvm3.24/matlab directory into mexw64 format;\
The files' name are the functions' name when used.

## 3.ArduinoIO：
Matlab 自带的ARDUINO HARDWARE SUPPORT PACKAGE，用于和下位机串口通信，\
使用前要将ArduinoIO/pde/aideos/aidoes.pde用arduino编译器烧录到单片机中，\
首次连接时需要将matlab工作目录选择到该文件夹下。

The ARDUINO HARDWARE SUPPORT PACKAGE that comes with Matlab, which is used to communicate with the serial port of the lowe-level computer.\
Before use, ArduinoIO/pde/aideos/aidoes.pde should be written into the microcontroller with the arduino compiler.
When connecting for the first time, you need to select the matlab working path to this folder.

## 4.Func:
自定义函数文件，函数功能介绍详见各函数文件。

Self-defined function. For detailed function description, please refer to README.md file in the Func directory.

## 5.train&test:
其中trainonline.m文件为训练分类器时使用，testonline.m为测试时使用，\
两个文件均不需要连接采集卡和下位机，只用来信号处理。\

The trainonline.m is used when training the classifier, and the testonline.m is used when testing.\
These two files are only used for signal processing. You do not need to be connected to the acquisition card or the lowe-level computer.

## 6.GUI:
系统通过GUI集成，使用前需要将训练好的模型和归一化准则放至该文件夹中；\
GUI/monitor.m 为系统主程序，集成上述功能。

This robot control system is integrated through the GUI, and the trained model and normalization rules need to be placed in this folder before using;\
GUI/monitor.m is the main program of the system, which integrates the above functions.

## 7.plot:
图表绘制程序；pre_pic绘制预处理效果；cluster_pic绘制特征聚类图；curve_pic绘制学习曲线，验证曲线。

Chart drawing program
pre_pic.m draws the pre-processing effect; 
cluster_pic.m draws the characteristic clustering diagram; 
curve_pic.m draws the learning curve and verification curve.



