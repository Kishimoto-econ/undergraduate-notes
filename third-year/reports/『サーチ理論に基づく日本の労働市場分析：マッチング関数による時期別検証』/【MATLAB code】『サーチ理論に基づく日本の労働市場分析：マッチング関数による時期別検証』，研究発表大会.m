data = readtable('C:\Users\Kohsu\OneDrive\ドキュメント\東洋大学3年次\研究発表大会\【推計用データ】『サーチ理論に基づく日本の労働市場分析^7マッチング関数による時期別検証』，研究発表大会.csv');
data.Properties.VariableNames = {'year','emp','recru','unemp','trend','d_antei','d_bubble','d_houkai','d_lehman','d_korona','d_koizumi'};
% data.Properties.VariableNames;

year = data.year;
emp = log(data.emp);
recru = log([NaN; data.recru(1:end-1)]);
unemp = log([NaN; data.unemp(1:end-1)]);
trend = data.trend;
d_antei = data.d_antei;
d_bubble = data.d_bubble;
d_houkai = data.d_houkai;
d_lehman = data.d_lehman;
d_korona = data.d_korona;
d_koizumi = data.d_koizumi;

%% ADF検定 
% [h,pValue,stat,cValue] = adftest(emp)
% [h,pValue,stat,cValue] = adftest(recru)
% [h,pValue,stat,cValue] = adftest(unemp)
%% 研究発表大会用(規模に関して収穫一定)
y = diff(emp - unemp);
x = diff(recru - unemp);

data_reg = table(x, y, d_antei(2:end), d_bubble(2:end), d_houkai(2:end), d_koizumi(2:end), d_lehman(2:end), d_korona(2:end));
data_reg.Properties.VariableNames = {'x', 'y', 'd_antei', 'd_bubble', 'd_houkai', 'd_koizumi', 'd_lehman', 'd_korona'}


% モデル1
mdl1 = fitlm(data_reg, 'y ~ x');
disp(mdl1)

%モデル2（安定成長期＋バブル期＋崩壊期）
mdl2 = fitlm(data_reg, 'y ~ x + d_antei + d_bubble + d_houkai + x:d_antei + x:d_bubble + x:d_houkai');
disp(mdl2)

% モデル3（小泉＋リーマン＋コロナ）
mdl3 = fitlm(data_reg, 'y ~ x + d_koizumi + d_lehman + d_korona + x:d_koizumi + x:d_lehman + x:d_korona');
disp(mdl3)

