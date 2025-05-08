function [kneeAngles_deg] = getKneeAngle(mocap)
%GETKNEEANGLE Summary of this function goes here
%   Detailed explanation goes here
    q_femur = quaternion(mocap.fem_rot_w, mocap.fem_rot_x, mocap.fem_rot_y, mocap.fem_rot_z);
    q_tibia = quaternion(mocap.tib_rot_w, mocap.tib_rot_x, mocap.tib_rot_y, mocap.tib_rot_z);
    
    q_rel = q_tibia .* conj(q_femur);
    
    % Extract the angle in radians
    q_rel_compact = compact(q_rel);
    kneeAngles_rad = 2 * acos(abs(q_rel_compact(:,1)));  % Only use w component;
    
    % The angle cannot be determined for the last sample. It results a NaN
    % value at the end of the vector. Replacing it with the previous value.
    if (numel(kneeAngles_rad) ~= numel(rmmissing(kneeAngles_rad)))
        N = numel(kneeAngles_rad);
        kneeAngles_rad(N) = kneeAngles_rad(N-1);
    end

    % Convert to degrees if needed
    kneeAngles_deg = 180 - rad2deg(kneeAngles_rad);
    %kneeAngles_filt = butterworthFilter(kneeAngles_deg, 200, 'low');

end

