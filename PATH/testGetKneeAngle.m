% Test script for getKneeAngle function
function testGetKneeAngle()
    % 1. Test with synthetic data - known angles
    fprintf('Running tests with synthetic data...\n');
    
    % Test case 1: 90-degree knee angle
    fprintf('\nTest case 1: 90-degree knee angle\n');
    mocap1 = createMocapData(90);
    [kneeAngles_deg] = getKneeAngle(mocap1);
    verifyResults(kneeAngles_deg, 90);
    
    % Test case 2: 45-degree knee angle
    fprintf('\nTest case 2: 45-degree knee angle\n');
    mocap2 = createMocapData(45);
    [kneeAngles_deg] = getKneeAngle(mocap2);
    verifyResults(kneeAngles_deg, 45);
    
    % Test case 3: 0-degree knee angle (straight leg)
    fprintf('\nTest case 3: 0-degree knee angle (straight leg)\n');
    mocap3 = createMocapData(0);
    [kneeAngles_deg] = getKneeAngle(mocap3);
    verifyResults(kneeAngles_deg, 0);
    
    % Test case 4: 135-degree knee angle (deeply flexed)
    fprintf('\nTest case 4: 135-degree knee angle (deeply flexed)\n');
    mocap4 = createMocapData(135);
    [kneeAngles_deg] = getKneeAngle(mocap4);
    verifyResults(kneeAngles_deg,135);
    
    % 2. Test with time-series data (simulated walking pattern)
    fprintf('\nTest case 5: Simulated walking pattern\n');
    angleProfile = [10, 15, 30, 45, 60, 45, 30, 15, 10];
    simulateWalkingTest(angleProfile);
end

% Helper function to create mock mocap data with specified knee angle
function mocap = createMocapData(kneeAngle_deg)
    % Convert desired knee angle to quaternion representation
    % For simplicity, we'll align to principal axes
    
    % Femur rotation - identity quaternion (aligned with global frame)
    mocap.fem_rot_w = 1;
    mocap.fem_rot_x = 0;
    mocap.fem_rot_y = 0;
    mocap.fem_rot_z = 0;
    
    % Tibia rotation - rotated around X axis by kneeAngle_deg
    % Convert knee angle to our quaternion representation
    % Note: The function uses (180 - angle), so we need to account for that
    actualAngle_rad = deg2rad(180 - kneeAngle_deg);
    halfAngle = actualAngle_rad / 2;
    
    mocap.tib_rot_w = cos(halfAngle);
    mocap.tib_rot_x = sin(halfAngle);
    mocap.tib_rot_y = 0;
    mocap.tib_rot_z = 0;
end

% Helper function to verify results
function verifyResults(kneeAngles_deg, expectedAngle_deg)
    
    fprintf('Expected angle: %.2f degrees (%.4f radians)\n', expectedAngle_deg);
    fprintf('Calculated angle: %.2f degrees (%.4f radians)\n', kneeAngles_deg);
    
    tolerance = 1e-4;
    if abs(kneeAngles_deg - expectedAngle_deg) < tolerance
        fprintf('✓ Test PASSED\n');
    else
        fprintf('✗ Test FAILED - Difference: %.4f degrees\n', abs(kneeAngles_deg - expectedAngle_deg));
    end
end

% Simulate a walking pattern and test
function simulateWalkingTest(angleProfile)
    % Create time-series data
    numFrames = length(angleProfile);
    kneeAngles_deg_result = zeros(numFrames, 1);
    
    for i = 1:numFrames
        mocap = createMocapData(angleProfile(i));
        [kneeAngles_deg] = getKneeAngle(mocap);
        kneeAngles_deg_result(i) = kneeAngles_deg;
    end
    
    % Verify results
    fprintf('Expected angles: ');
    fprintf('%.1f ', angleProfile);
    fprintf('\nCalculated angles: ');
    fprintf('%.1f ', kneeAngles_deg_result);
    fprintf('\n');
    
    % Plot results
    figure;
    plot(1:numFrames, angleProfile, 'b-o', 'LineWidth', 2, 'DisplayName', 'Expected');
    hold on;
    plot(1:numFrames, kneeAngles_deg_result, 'r--x', 'LineWidth', 2, 'DisplayName', 'Calculated');
    title('Knee Angle Calculation Verification');
    xlabel('Frame');
    ylabel('Knee Angle (degrees)');
    legend('show');
    grid on;
end