clear all; close all; clc; 

%% Set up for Digitimer (with psychtoolbox)
devices=PsychHID('Devices');
portnum1=0;
deviceid=DaqDeviceIndex();
dio1=DaqDConfigPort(deviceid, portnum1,0); %DaqDConfigPort (DeviceIndex, port(0=A, 1=B), direction (0=output, 1=input)

                                                            
%%
% ---Set up rh and ar trials--- %
numPulse = 10; %num of pulses per train
numTrials = 150; %num trials per condition

%Set pauses between pulses for ar condition
rng('shuffle')
c = 1;
for k = 1:numTrials
    A = rand(1,numPulse-1);
    tPause_ctrl(k,:) = A/sum(A)*0.747; %the sum of the pauses has to be equal to the rh condition (i.e. 0.083*9)
    tmpCondRand = any(tPause_ctrl(k,:) < 0.01); %pauses cannot be lower than 10ms
    while tmpCondRand == 1
        A = rand(1,numPulse-1);
        tPause_ctrl(k,:) = A/sum(A)*0.747;
        fprintf('\nRandomising again n: %d\n', c)
        disp(['K = ', num2str(k)])
        c = c+1;
        tmpCondRand = any(tPause_ctrl(k,:) < 0.01);
    end 
end
tPause_ctrl(:,numPulse+1) = zeros;


%Set pauses between pulses for rh condition
tPause_alpha = zeros(numTrials,numPulse);
for p = 1:numPulse-1
    tPause_alpha(:,p) = ones(numTrials,1) - (1-0.083); %all pauses will be of 0.083ms 
end


%% Set up for StimTracker
[handle,error]=IOPort('OpenSerialPort', '/dev/cu.usbserial-A900a2LF');
IOPort('ConfigureSerialPort', handle, 'BaudRate=115200, Databits= 8, StopBits=1, FlowControl=None, Timeout= 1, InputBufferSize= 16000');
pulse_time= typecast(uint32(20), 'uint8');

pause(3);


%% Start study
condi=[ones(1,150), ones(1,150)+1]';
condi=Shuffle(condi);
numTrials=300;

for j=1:numTrials  

    %Trial rhythmic
    if condi(j,1) ==1
        
        for i=1:10
            tic; tstart=tic;
            DaqDOut(deviceid,portnum1,1);
            DaqDOut(deviceid,portnum1,0);
            disp 'Condi=1';
            
            %Send trigger to StimTracker            
            IOPort('Write', handle, uint8(['mp' pulse_time])); 
            IOPort('Write', handle, uint8(['mh' 2])); 
            
            %pause between pulses
            telapsed (i) = toc(tstart);
            pause (tPause_alpha(j,i)-telapsed(i));
    
        end
 
    
    %Trial arrhythmic
    else if condi(j,1) ==2
            
        for i=1:10
            tic; tstart=tic;
            DaqDOut(deviceid,portnum1,1);
            DaqDOut(deviceid,portnum1,0);
            disp 'Condi=2'
                        
            %Send trigger to StimTracker           
            IOPort('Write', handle, uint8(['mp' pulse_time])); 
            IOPort('Write', handle, uint8(['mh' 4])); 
            
            %pause between pulses 
            telapsed (i)= toc(tstart);
            pause (tPause_ctrl(j,i)-telapsed (i)); 

        end
        
        end
        
    end
            
                 
    disp(['Trial ' num2str(j) '/300']) %Will display what trial you are on

    
    %Breaks throughout the study     
    if j==75;
        disp 'paused at trial 75, press any key to continue';pause; 
    else if j==150;
             disp 'paused at trial 150, press any key to continue'; pause;
        else if j==225;
                 disp 'paused at trial 225, press any key to continue'; pause;
            else if j==300;
                    disp 'END';
                end
            end
        end
    end
   
    %Pause between trials
    WaitSecs (4);
    
end                                                          
       
save(save_name);

