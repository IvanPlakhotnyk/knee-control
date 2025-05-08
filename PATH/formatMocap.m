function formated_mocap = formatMocap(mocap_table)
    %Removes first four rows, which are artifacts of readtable('mocap.csv')
    formated_mocap = mocap_table;
    %formated_mocap(1:4,:) = []; // For already formatted 1/1.5/2 kph
    %speeds
    formated_mocap.Properties.VariableNames(1) = "frame";
    formated_mocap.Properties.VariableNames(2) = "time";
    formated_mocap.Properties.VariableNames(3) = "fem_rot_x";
    formated_mocap.Properties.VariableNames(4) = "fem_rot_y";
    formated_mocap.Properties.VariableNames(5) = "fem_rot_z";
    formated_mocap.Properties.VariableNames(6) = "fem_rot_w";
    formated_mocap.Properties.VariableNames(7) = "fem_pos_x";
    formated_mocap.Properties.VariableNames(8) = "fem_pos_y";
    formated_mocap.Properties.VariableNames(9) = "fem_pos_z";
    formated_mocap.Properties.VariableNames(10) = "fut_rot_x";
    formated_mocap.Properties.VariableNames(11) = "fut_rot_y";
    formated_mocap.Properties.VariableNames(12) = "fut_rot_z";
    formated_mocap.Properties.VariableNames(13) = "fut_rot_w";
    formated_mocap.Properties.VariableNames(14) = "fut_pos_x";
    formated_mocap.Properties.VariableNames(15) = "fut_pos_y";
    formated_mocap.Properties.VariableNames(16) = "fut_pos_z";
    formated_mocap.Properties.VariableNames(17) = "tib_rot_x";
    formated_mocap.Properties.VariableNames(18) = "tib_rot_y";
    formated_mocap.Properties.VariableNames(19) = "tib_rot_z";
    formated_mocap.Properties.VariableNames(20) = "tib_rot_w";
    formated_mocap.Properties.VariableNames(21) = "tib_pos_x";
    formated_mocap.Properties.VariableNames(22) = "tib_pos_y";
    formated_mocap.Properties.VariableNames(23) = "tib_pos_z";
end