function [r_c,r_d] = separateReturns(ret,cut)

r_c = ret;
r_c(abs(r_c) > cut) = 0; % if return is jump, set it to zero

r_d = ret;
r_d(abs(r_d) <= cut) = 0; % if return is diffusive, set it to zero

end

