% a=arduino('com4');

servoAttach(a,7);servoAttach(a,8);servoAttach(a,9);
servoAttach(a,10);servoAttach(a,11);
result=[0,1,3,4,5,5,5,0,3,0,4,0,1,0,5,0];

for m=1:16
    switch result(m)
        case 0
            servoWrite(a,7,40);servoWrite(a,8,140);servoWrite(a,9,140);
            servoWrite(a,10,140);servoWrite(a,11,40);% ¿ØÖÆ»úÐµÊÖ
            
        case 1
            servoWrite(a,7,0);servoWrite(a,8,160);servoWrite(a,9,180);
            servoWrite(a,10,180);servoWrite(a,11,0);
            
        case 3
            servoWrite(a,7,100);servoWrite(a,8,100);servoWrite(a,9,180);
            servoWrite(a,10,180);servoWrite(a,11,0);
            
        case 4
            servoWrite(a,7,100);servoWrite(a,8,100);servoWrite(a,9,80);
            servoWrite(a,10,80);servoWrite(a,11,100);
            
        case 5
            servoWrite(a,7,100);servoWrite(a,8,160);servoWrite(a,9,80);
            servoWrite(a,10,180);servoWrite(a,11,0);
            
    end
    m=m+1;
    pause(1.5);
end