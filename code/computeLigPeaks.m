function trials = computeLigPeaks(trials)
    
    HS_PEAK_TH = -1.1;
    HS_PREDICTOR_PEAK = 3.9;%The one that happens just before the peak of interest.
    for i = 1:numel(trials.lig_a)
        trials.aHSPeaks{i} = -getPeaksWithTH(-trials.lig_a{i}, HS_PEAK_TH);
        %trials.aHSPredictorPeaks{i} = getPeaksWithTH(trials.lig_a{i}, HS_PREDICTOR_PEAK);
    end

end