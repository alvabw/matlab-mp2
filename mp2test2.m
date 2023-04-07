
% Reshape data into a 256x7291 matrix gör bara det en gång dock! 
%trainDigits = reshape(trainDigits, [], size(trainDigits, 3));

% Split data into 10 sub-matrices based on trainAns
sub_trainDigits = cell(1, 10);
for i = 0:9
    sub_trainDigits{i+1} = trainDigits(:, trainAns == i);
end

% Access the first sub-data matrix (i.e., data points labeled as 0)
%sub_trainDigits_0 = sub_trainDigits{1};

%reuse code that we made before :3 
subspaces = cell(1, 10); 
for i = 1:10
    symetric = sub_trainDigits{i}*sub_trainDigits{i}'; 
    [eigvectors, eigvalues] = eig(symetric);
    
    re_eigvalues = reshape(eigvalues,65536,1); 
    re_eigvectors = reshape(eigvectors,65536,1);
    %descend start with biggest value 
  
    [re_eigvalues,sortIndex] = sort(re_eigvalues,'descend');
    re_eigvectors = re_eigvectors(sortIndex);

    %gör ett underrum med 10 egenvektorer med de största tillhörande egenvärdena
    subspace_placeholder = re_eigvectors(1:10,1);
    subspaces{i} = subspace_placeholder; 
    
end
 
result = cell(1:2007); 
for i = 1:2007
    object = testDigits(:,:,i); 
    reshape(object,256,1);

    residuals = cell(1,10);
    for j = 1:10
         projection_matrix = subspaces{j}*subspaces{j}';
         projection = projection_matrix*object; 
         residual = object - projection; 
         residuals{j} = norm(residual);
    end
     smallest_residual = min(cell2mat(residuals));
  
     result{i} = smallest_residual; 
end


%jämför result med alla från testAns och se om samma tal står på samma
%index





