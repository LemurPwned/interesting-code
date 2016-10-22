function GameofLife (iter, A)

%zero the egdes the matrix
for i = 2:size(A)
    for j = 2:size(A)
        if A(i,j) >10
            A(i,j) = 0;
        else A(i,j) = 1;
        end
    end
end
A(1:size(A))= 0;
A(1,1:size(A))= 0;
A(end,1:size(A))=0;
A(1:size(A),end)=0;

Noff_r= [-1, -1, 0, 1, 1,  1,  0, -1]; %the row offset of the 8 neighbors 
Noff_c=[ 0,  1, 1, 1, 0, -1, -1, -1]; %the column offset of the 8 neighbors
N=numel(Noff_r); % the number of neighbors each element has
for i = 0:iter
    count = zeros(size(A)-[2 2]); %A is the grid with a border of zeros
    for jj=1:N
        count=count + A(Noff_r(jj)+(2:end-1),Noff_c(jj)+(2:end-1)); %this is the heart
    end %now count will have the correct number of alive neighbors.
    newTurn = count;
    newTurn(newTurn>3) = 0;
    newTurn(newTurn<2) = 0;
    newTurn(newTurn==3) = 1;
    newTurn(newTurn==2) = 1;
    A(2:end-1, 2:end-1) = newTurn;
    imagesc (newTurn)
    pause (0.3)
end
end