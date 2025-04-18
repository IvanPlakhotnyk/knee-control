function formated_emg = formatEMG(emg_table)
    formated_emg = emg_table;
    formated_emg.Properties.VariableNames(1) = "frame";
    formated_emg.Properties.VariableNames(2) = "time";
    formated_emg.Properties.VariableNames(3) = "emgFrame";
    formated_emg.Properties.VariableNames(4) = "mucsA";
    formated_emg.Properties.VariableNames(5) = "mucsB";
end