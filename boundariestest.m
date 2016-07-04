%%boundariestest
clc, clear all, close all
       BW = imread('Figuras/fig1mod.jpg');
       BW = BW(:,:,1);
       [B,L,N,A] = bwboundaries(BW);
       imshow(BW); hold on;
            
       a = cell2mat(B)
     %  plot (a(1:1000,2), a(1:1200,1), '*')