function [data_mocap, data_daq, data_angle] = formatData(mocap_csv,daq_csv)
    %Formats the data for a given speed for further analysis.
    %   [mocap, daq, angle] = formatData('mocap.csv', 'daq.csv')
    data_mocap = formatMocap(readtable(mocap_csv));
    data_daq = formatDAQ(readtable(daq_csv));
    data_angle = getKneeAngle(data_mocap);
end

