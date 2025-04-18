function peaks = findPeaks (fsr)
    THRESHOLD = 3.3; % V
    NUM_SAMPLES_SEPARATION = 120; % 1s at 120Hz

    peaks = zeros(size(fsr));
    cnt = 0;

    for i = 1:size(fsr)
        if fsr(i) < THRESHOLD & cnt > NUM_SAMPLES_SEPARATION
            peaks(i) = 1;
            cnt = 0;
        end
        cnt = cnt+1;
    end
end