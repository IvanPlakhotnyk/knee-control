function formated_daq = formatDAQ(daq_table)
    formated_daq = removevars(daq_table, "DeviceFrame");
    formated_daq.Properties.VariableNames(1) = "frame";
    formated_daq.Properties.VariableNames(2) = "time";
    formated_daq.Properties.VariableNames(3) = "fsr";
    formated_daq.Properties.VariableNames(4) = "lig_a";
    formated_daq.Properties.VariableNames(5) = "lig_p";
end