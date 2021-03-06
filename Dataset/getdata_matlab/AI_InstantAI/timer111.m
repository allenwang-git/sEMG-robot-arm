
global num num1 num2 A
A=zeros(100,3);
num = 1;
num1 = 100;
num2 = 1000;
t = timer('StartDelay',1,'TimerFcn',@t_TimerFcn,'Period',0.1,'ExecutionMode','fixedRate');
start(t);
input('InstantAI is in progress...Press Enter key to quit!');
stop(t);
delete(t);

A=A+2;



%%  »Øµ÷º¯Êý
function t_TimerFcn(hObject,eventdata)
    global num A
    A(num,1)=num+1;
    A(num,2)=num+2;
    A(num,3)=num+3;
    disp(num2str(num))
    num = num + 1;
    
end
function t_TimerFcn1(~,~)
    global num1
    disp(num2str(num1))
    num1 = num1 + 1;
end
function t_TimerFcn2(~,~)
    global num2
    disp(num2str(num2))
    num2 = num2 + 1;
end
