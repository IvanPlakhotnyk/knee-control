function formated_mocap = formatMocap(mocap_table)
    %Removes first four rows, which are artifacts of readtable('mocap.csv')
    formated_mocap = mocap_table;
    formated_mocap(1:4,:) = [];
    formated_mocap.Properties.VariableNames(1) = "frame";
    formated_mocap.Properties.VariableNames(2) = "time";
    formated_mocap.Properties.VariableNames(3) = "fem_rot_x";
    formated_mocap.Properties.VariableNames(4) = "fem_rot_y";
    formated_mocap.Properties.VariableNames(5) = "fem_rot_z";
    formated_mocap.Properties.VariableNames(6) = "fem_rot_w";
    formated_mocap.Properties.VariableNames(7) = "fem_pos_x";
    formated_mocap.Properties.VariableNames(8) = "fem_pos_y";
    formated_mocap.Properties.VariableNames(9) = "fem_pos_z";
    formated_mocap.Properties.VariableNames(10) = "tib_rot_x";
    formated_mocap.Properties.VariableNames(11) = "tib_rot_y";
    formated_mocap.Properties.VariableNames(12) = "tib_rot_z";
    formated_mocap.Properties.VariableNames(13) = "tib_rot_w";
    formated_mocap.Properties.VariableNames(14) = "tib_pos_x";
    formated_mocap.Properties.VariableNames(15) = "tib_pos_y";
    formated_mocap.Properties.VariableNames(16) = "tib_pos_z";
end