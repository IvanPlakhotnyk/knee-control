function formated_daq = formatDAQ(daq_table)
    formated_daq = removevars(daq_table, "DeviceFrame");
    formated_daq.Properties.VariableNames(1) = "frame";
    formated_daq.Properties.VariableNames(2) = "time";
    formated_daq.Properties.VariableNames(3) = "fsr";
    formated_daq.Properties.VariableNames(4) = "lig_a";
    formated_daq.Properties.VariableNames(5) = "lig_p";
    formated_daq(:,4) = formated_daq(:,4) - mean(formated_daq(:,4));
    formated_daq(:,5) = formated_daq(:,5) - mean(formated_daq(:,5));
    formated_daq.lig_aFilt = butterworthFilter(formated_daq.lig_a, 200, 'bandpass');
    formated_daq.lig_pFilt = butterworthFilter(formated_daq.lig_p, 200, 'bandpass');
end