
%% ��������� ������

% you can download this file from https://yadi.sk/d/-oLo6E7Y3ZfJJj
data = get_data_mnist('C:\Users\Grossmend\Desktop\repositories\_data\MATLAB\mnist\mnist_data.csv');

%% ��������� ������� �� �������� � �������������

trainPercent = 0.7;

[trainData, ...
 trainTarget, ...
 testData, ...
 testTarget] = split_mnist_data(data, trainPercent);

%% ��������� ��������� ����

% ���-�� ������� ����������
inodes = size(trainData,2);

% ���-�� ������� ����� 1-��� ����
hnodes = 150;

% ���-�� �������� ����������
onodes = 10;

% ����. �������� �������� 
lr = 0.3;

%% ������� ��������

tic

% ����� ��� ��������� ������� ����. ����� ������� � �������
sigmIn = (hnodes^(-0.5));
% ����� ��� ��������� ������� ����. ����� ������� � ��������
sigmOut = (onodes^(-0.5));

% ��������� ������� ����� ����� �������� ����������� � ������� ����� (�� ������)
wih = sigmIn.*randn(hnodes, inodes);
% ��������� ������� ����� ����� ������� ����� � ��������� ����������� (�� ������)
who = sigmOut.*randn(onodes, hnodes);

% ������� ��������� ����
for i = 1:size(trainData,1)
    aim = ones(onodes,1)*0.01;
    aim(trainTarget(i,1)) = 0.99;
    inputs = ((trainData(i,:)/255 * 0.99) + 0.01)';
    [wih, who] = trainNeural(inputs, aim, wih, who, lr);
end

% ��������� ��������� ����
ans_arr = zeros(size(testData,1),1);
for i = 1:size(testData,1)
    inputsTest = testData(i,:)';
    ansNeural = questNeural(inputsTest, wih, who);
    [~,ansMaxInd] = max(ansNeural);
    if testTarget(i,1) == ansMaxInd
        ans_arr(i) = 1;
    end
end

disp(['������������� ���� �����: ', num2str(sum(ans_arr)/length(ans_arr))])

toc
% %% ���������� ��������� ���� ��� ������ ��������� ��������
% 
% tic
% 
% % ��������� ��������� ����
% inputsTest = imread('C:\Users\market8\Desktop\GitHub\MATLAB_NN\MNIST_perceptron\files\test.png');
% 
% testImg = inputsTest(:,:,1);
% testImg = 255.0 - testImg;
% testImg = im2double(testImg);
% 
% % ���������� �� ������
% imshow(reshape(testImg, 28,28));
% 
% % ������������ ������, ��� ����������� �������������, ��� � ��������
% testImg = rot90(fliplr(testImg),1);
% 
% % ��������������� � ������
% testImg = reshape(testImg, 1, 28*28)';
% 
% ansNeural = questNeural(testImg, wih, who) %#ok
% [~, ansBest] = max(ansNeural); 
% 
% disp([num2str(max(ansNeural)*100), ' - ��������� ����������� ���� ���: ', num2str(ansBest)])

toc