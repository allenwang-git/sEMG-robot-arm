By Wang Yinuo
2020.05.22
Contect:dbdxwyn@163.com


1.dataset:
数据集，raw.mat为原始数据，已打标签；moni.mat为测试集，未打标签。


2.libsvm3.24:
SVM工具箱，使用前存至matlab/toolbox目录下，将libsvm3.24/matlab目录下各函数C文件全部编译为mexw64格式;
之后调用时文件名即为函数名。


3.ArduinoIO：
Matlab 自带的ARDUINO HARDWARE SUPPORT PACKAGE，用于和下位机串口通信，
使用前要将ArduinoIO/pde/aideos/aidoes.pde用arduino编译器烧录到单片机中，
首次连接时需要将matlab工作目录选择到该文件夹下。


4.func:
自定义函数文件，函数功能介绍详见各函数文件。


5.train&test:
其中train文件为训练分类器时使用，test为测试时使用，
两个文件均不需要连接采集卡和下位机，只用来信号处理。


6.gui:
系统通过GUI集成，使用前需要将训练好的模型和归一化准则放至该文件夹种；
gui/monitor.m 为系统主程序，集成上述功能。


7.plot:
论文涉及各图表绘制程序；pre_pic绘制预处理效果；cluster_pic绘制特征聚类图；curve_pic绘制学习曲线，验证曲线。





