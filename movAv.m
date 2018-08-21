function output = movAv(x,n)

% Preallocate output
output=NaN(1,numel(x));
% Find mid point of n
midPoint = round(n/2);
% For length of input, minus n
for a = 1:length(x)-n
    
    % Find index range to take average over
    b=a+n;
    % Calculate mean
    output(a+midPoint) = mean(x(a:b));
    
end

end