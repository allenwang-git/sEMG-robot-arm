% InstantAI.m
%
% Example Category:
%    AI
% Matlab(2010 or 2010 above)
%
% Description:
%    This example demonstrates how to use Instant AI function.
%
% Instructions for Running:
%    1. Set the 'deviceDescription' for opening the device. 
%    2. Set the 'startChannel' as the first channel for scan analog samples  
%    3. Set the 'channelCount' to decide how many sequential channels to 
%       scan analog samples.
%
% I/O Connections Overview:
%    Please refer to your hardware reference manual.

function InstantAI()

% Make Automation.BDaq assembly visible to MATLAB.
BDaq = NET.addAssembly('Automation.BDaq4');

% Configure the following three parameters before running the demo.
% The default device of project is demo device, users can choose other 
% devices according to their needs. 
deviceDescription = 'PCI-1716,BID#0'; 
startChannel = int32(0);
channelCount = int32(3);

% Step 1: Create a 'InstantAiCtrl' for Instant AI function.
instantAiCtrl = Automation.BDaq.InstantAiCtrl();

try
    % Step 2: Select a device by device number or device description and 
    % specify the access mode. In this example we use 
    % AccessWriteWithReset(default) mode so that we can fully control the 
    % device, including configuring, sampling, etc.
    instantAiCtrl.SelectedDevice = Automation.BDaq.DeviceInformation(...
        deviceDescription);
    data = NET.createArray('System.Double', channelCount);
    
    % Step 3: Read samples and do post-process, we show data here.
    errorCode = Automation.BDaq.ErrorCode();
    t = timer('TimerFcn', {@TimerCallback, instantAiCtrl, startChannel, ...
        channelCount, data}, 'period', 1, 'executionmode', 'fixedrate', ...
        'StartDelay', 1);
    start(t);
    input('InstantAI is in progress...Press Enter key to quit!');
    stop(t);
    delete(t);
catch e
    % Something is wrong.
    errorCode = Automation.BDaq.ErrorCode()
    if BioFailed(errorCode)    
        errStr = 'Some error occurred. And the last error code is ' ... 
            + errorCode.ToString();
    else
        errStr = e.message;
    end
    disp(errStr); 
end

% Step 4: Close device and release any allocated resource.
instantAiCtrl.Dispose();

end

function result = BioFailed(errorCode)

result =  errorCode < Automation.BDaq.ErrorCode.Success && ...
    errorCode >= Automation.BDaq.ErrorCode.ErrorHandleNotValid;

end

function TimerCallback(obj, event, instantAiCtrl, startChannel, ...
    channelCount, data)

errorCode = instantAiCtrl.Read(startChannel, channelCount, data); 
if BioFailed(errorCode)
    throw Exception();
end
fprintf('\n');
for j=0:(channelCount - 1)
    fprintf('channel %d : %10f ', j, data.Get(j));
end

end