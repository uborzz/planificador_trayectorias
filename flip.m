function M2 = flip(M)
    
M2 = M;
[x, y] = size(M)
    for i = 1:x
        M2(i,:) = M(x+1-i,:);
    end
end