function avgTrial = averageTrial(trials)
    avgTrial = mean(cell2mat(trials), 1);
end