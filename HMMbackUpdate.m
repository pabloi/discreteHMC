function [smoothedStateDistr] = HMMbackUpdate(nextStateSmoothedDistr,currStateDistr,nextStateGivenCurrDistr,nextStatePredictedDistr)
%Smoothing step in the Kalman smoother for generic (numeric) distributions
%Implements: p(x_k|{y}) = p(x_k) \int p(x_{k+1}|x_k) p(x_{k+1}|{y})/p(x_{k+1}|{y_k}) dx_{k+1}
%INPUT
%nextStateSmoothedDistr: p(x_{k+1}|{y}) [SMOOTHED NEXT STATE]
%currStateDistr: p(x_k) [FILTERED CURRENT STATE]
%nextStateGivenCurrDistr: p(x_{k+1}|x_k) [TRANSITION MATRIX]
%nextStatePredictedDistr: p(x_{k+1}|y_k) [FILTERED NEXT STATE]
%OUTPUT
%smoothedStateDistr: p(x_k|{y})

tol=1e-15;
innov=(nextStateSmoothedDistr./(nextStatePredictedDistr+tol));
smoothedStateDistr=currStateDistr .* (nextStateGivenCurrDistr'*innov);
s=sum(smoothedStateDistr);
if s==0
    error('Inconsistent successive states during smoothing. Impossible update.')
end
smoothedStateDistr=smoothedStateDistr/s; %Unnecessary if we only care about MAP
end
