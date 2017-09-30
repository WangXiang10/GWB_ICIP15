function ComBorRat = CommonBorderRatioSpeedUp(rgb, pixelList, sp, adjcMatrix)

if nargin < 3
    comp_mean = 0;
end

labels = unique(sp);
num_sp = length(labels);

% compute means and edges
e = zeros(size(sp));
s = zeros(size(sp));
se = zeros(size(sp));

e(:,1:end-1) = sp(:,2:end);
s(1:end-1,:) = sp(2:end,:);
se(1:end-1,1:end-1) = sp(2:end,2:end);

edges = (sp~=e | sp~=s | sp~=se);
edges(end,:) = (sp(end,:)~=e(end,:));
edges(:,end) = (sp(:,end)~=s(:,end));
edges(end,end) = 0;

edgeInd = find(edges == 1);

[h, w] = size(sp);
bnd = sub2ind([h, w], ones(1, w), 1: w);
bnd = [bnd, sub2ind([h, w], h * ones(1, w), 1: w)];
bnd = [bnd, sub2ind([h, w], 1: h, ones(1, h))];
bnd = [bnd, sub2ind([h, w], 1: h, w * ones(1, h))];

edgeInd = setdiff(edgeInd, bnd);
% [bndi, bndj] = ind2sub([h, w], bnd);
edge1 = edgeInd - 1;
edge2 = edgeInd + 1;
edge3 = edgeInd - size(sp, 1);
edge4 = edgeInd + size(sp, 1);

reg1 = sp(edge1);
reg2 = sp(edge2);
reg3 = sp(edge3);
reg4 = sp(edge4);

% reg = [reg1, reg2, reg3, reg4];
% regEdge = [];
% tic
% for i =  1: size(reg, 1)
%     tmp = sort(unique(reg(i, :)));
%     if length(tmp) ~= 1
%         regEdge = [regEdge; tmp(1:2), tmp(1) * num_sp + tmp(2)];
%     end
% end

regEdge = [reg1, reg2];
tmp = regEdge(:, 1) - regEdge(:, 2);
f0 = find(tmp == 0);
regEdge(f0, 2) = reg3(f0);
tmp = regEdge(:, 1) - regEdge(:, 2);
f0 = find(tmp == 0);
regEdge(f0, 2) = reg4(f0);
tmp = regEdge(:, 1) - regEdge(:, 2);
f0 = find(tmp == 0);
regEdge(f0, :) = [];

regEdge = sort(regEdge, 2);
regEdge(:, 3) = regEdge(:, 1) * num_sp + regEdge(:, 2);
regSide = tabulate([regEdge(:,1); regEdge(:,2)]);
regSide = regSide(:, 2);
comSide = tabulate(regEdge(:, 3));
comSide = comSide(:, 2);
comSide(end+1: num_sp * num_sp) = 0;
ComBorRat = zeros(num_sp, num_sp);
for i = 1: num_sp - 1
    ComBorRat(i, i) = 1;
    for j = i + 1: num_sp
        if adjcMatrix(i, j)
            ComBorRat(i, j) = max(comSide(i * num_sp + j ) / regSide(i), comSide(i * num_sp + j ) / regSide(j));
            ComBorRat(j, i) =  ComBorRat(i, j);
        end
    end
end
ComBorRat(num_sp, num_sp) = 1;

end



