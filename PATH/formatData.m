function [data_mocap, data_daq, data_emg] = formatData(mocap_csv,daq_csv, emg_csv)
%Formats the data for a given speed for further analysis.
%   [data_mocap, data_daq, data_emg] = formatData(mocap_csv,daq_csv, emg_csv)
data_mocap = formatMocap(readtable(mocap_csv));
data_daq = formatDAQ(readtable(daq_csv));
data_emg = formatEMG(readtable(emg_csv));

end

