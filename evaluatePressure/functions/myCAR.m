function CAR = myCAR(AR)

mySum = 0;
i = 1;
myOldSum = 9999;

while (abs(mySum - myOldSum) > 1e-3)
    myOldSum = mySum;
    mySum = mySum + tanh(i * pi / (2 * AR)) / i^5;
    i = i + 2;
end

CAR = 1 - 192 * AR / pi^5 * mySum;

end