$include set.gms
$include data.gms


CostOfDurty_test(D)=0;
CostOfDurty_test('1')=300;
CostOfDurty_test('2')=340;
CostOfDurty_test('3')=335;
CostOfDurty_test('4')=275;
CostOfDurty_test('5')=360;
CostOfDurty_test('6')=300;
CostOfDurty_test('7')=340;
CostOfDurty_test('8')=421;
duties_test(D, F)=0;
duties_test('1','1')=1;
duties_test('2','2')=1;
duties_test('3','3')=1;
duties_test('4','4')=1;
duties_test('5','5')=1;
duties_test('6','6')=1;
duties_test('7','7')=1;
duties_test('8','7')=1;
duties_test('8','1')=1;
         execute_unload 'All_Duty' duties_test;
         execute_unload 'cost_Duty' CostOfDurty_test;