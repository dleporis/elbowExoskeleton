% %% THE LOOP
Motor1 = Epos4(1,0);
Motor1.EnableNode;
Motor1.SetOperationMode( OperationModes.ProfileVelocityMode );
Motor1.ClearErrorState;

countMyos = 1; % number of myos connected

mm = MyoMex(countMyos);
m = mm.myoData(1);
m.timeIMU
T = 3;
m.startStreaming();
pause(T);
m.stopStreaming();
go = true;
while go
     while m.pose_fist == true
        Motor1.MotionInVelocity(1000);
     end
     delete(Motor1);
     Motor1 = Epos4(1,0);
     Motor1.EnableNode;
     while m.pose_wave_out == true
        Motor1.MotionInVelocity(-1000);
     end
     delete(Motor1);
     Motor1 = Epos4(1,0);
     Motor1.EnableNode;
     if m.pose_wave_in == true
        Motor1.Stop;
        go=false
     end
end
delete(Motor1);
mm.delete;
