*	Given that World Bank data is collected through national statistical agencies and various inter-governmental organizations, including the UN and WHO, we can assume that there is minimal measurement error in our data. I would definitely classify it as a reliable source, with minimal exogenous biases in reporting. After importing the World Bank data for FDI and GDP, which stretched from the years 1960-2018, I was able to begin creating a for loop for both of them to display the FDI and GDP values back-to-back, organized by “countryname” and “year”. This encompassed the majority of my cleaning process. Furthermore, I added 14 other control variables, which will tend to diminish as we go further into controlling for endogeneity biases in my regression analysis. There are many factors that would affect foreign confidence and investment into a country besides a growing enrichment of its people; this would include existing robust infrastructure, health and educational status, political stability, and existing relative exchange rates which would affect rate of return on investment among many other things. I also chose to control for homicide rates, as I believe homicide rates are very relevant in discussions on Latin America, especially for countries such as El Salvador, Hondorus, and Venezuela. In any case, I had to create other loops for all of this imported data. We can also see that for all the below loops, I had to drop extraneous columns of data and had to merge each data frame created from the loop structure. Additionally, I reshaped my data from a wide to long format, so that I could view “countryname” and “year” all on the same page along with their various data points just by scrolling down. All my data sets merged perfectly, 1:1, where they all shared the same “countryname” and “year” categorization. Lastly, after merging my data sets, I dropped the merge variable as it was no longer needed. 

import delimited "/Users/patrickpoleshuk/Downloads/API_IC.LGL.CRED.XQ_DS2_en_csv_v2_1563361/API_IC.LGL.CRED.XQ_DS2_en_csv_v2_1563361.csv", encoding(UTF-8) clear 


forvalues x=5(1)64{
local y= `x' +1955
rename v`x' LEGAL`y'
}

* Here is a variable for the "Strength of the Legal Rights Index" (from 0-12, where 0 signfies the weakest legal institutions and 12 signfies a country has the strongest possible legal institutions in a given year).

rename v1 countryname
drop v65 v66 v3 v4 v2
reshape long LEGAL, i(countryname) j(year)
sort countryname year
save "/Users/patrickpoleshuk/Downloads/LEGAL.dta", replace


*-----
import delimited "/Users/patrickpoleshuk/Downloads/API_EG.USE.ELEC.KH.PC_DS2_en_csv_v2_1565012/API_EG.USE.ELEC.KH.PC_DS2_en_csv_v2_1565012.csv", encoding(UTF-8) clear 

forvalues x=5(1)64{
local y= `x' +1955
rename v`x' ELEC`y'
}

* The variable ELEC controls for "Electric Power Consumption (kWh per capita)", which could be a proxy for industrialized growth. We can hypothesis, then, that the coefficent effect of ELEC will have a positive effect on the FDI going into a given country. 

rename v1 countryname
drop v65 v66 v3 v4 v2
reshape long ELEC, i(countryname) j(year)
sort countryname year
save "/Users/patrickpoleshuk/Downloads/ELEC.dta", replace

*-----
import delimited "/Users/patrickpoleshuk/Downloads/API_GC.DOD.TOTL.GD.ZS_DS2_en_csv_v2_1566293/API_GC.DOD.TOTL.GD.ZS_DS2_en_csv_v2_1566293.csv", encoding(UTF-8) clear 

forvalues x=5(1)64{
local y= `x' +1955
rename v`x' DEBT`y'
}

* Here I'm controlling for "Central Government Debt" as a total % of a country's GDP. I would predict that this variable has a negative impact on FDI, but I believe this depends on the nature of the debt. If a higher debt to GDP ratio is the result of funding warfare activities, then I believe this will have a negative impact on FDI. However, if, for example, a country is undergoing expansionary fiscal or monetary policy to offset minor economic setbacks, FDI may be unchanged. 

rename v1 countryname
drop v65 v66 v3 v4 v2
reshape long DEBT, i(countryname) j(year)
sort countryname year
save "/Users/patrickpoleshuk/Downloads/DEBT.dta", replace

*------
import delimited "/Users/patrickpoleshuk/Downloads/API_SE.PRM.NENR_DS2_en_csv_v2_1565149/API_SE.PRM.NENR_DS2_en_csv_v2_1565149.csv", encoding(UTF-8) clear 

forvalues x=5(1)64{
local y= `x' +1955
rename v`x' SCHOOL`y'
}

* The variable SCHOOL measures primary school enrollment as a net % of the population. Education is an integral part of calculating the Human Development Index (HDI), so I would predict that a higher % enrollment in primary school would correspond with higher FDI inflows. 

rename v1 countryname
drop v65 v66 v3 v4 v2
reshape long SCHOOL, i(countryname) j(year)
sort countryname year
save "/Users/patrickpoleshuk/Downloads/SCHOOL.dta", replace

*------
import delimited "/Users/patrickpoleshuk/Downloads/API_SH.DYN.MORT_DS2_en_csv_v2_1499522/API_SH.DYN.MORT_DS2_en_csv_v2_1499522.csv", encoding(UTF-8) clear 

forvalues x=5(1)64{
local y= `x' +1955
rename v`x' MORT`y'
}

* Similar to the variable below, I am attempting to control for the health of a given country. The variable MORT measures the infant mortality rates, per 1,000 births, where an "infant" is classified as any child under 5 years of age. A lower infant mortality rate should correspond to a higher FDI, but I may run into issues with multicollinearity as the variable of LIFE may be correlated with this variable. 
rename v1 countryname
drop v65 v66 v3 v4 v2
reshape long MORT, i(countryname) j(year)
sort countryname year
save "/Users/patrickpoleshuk/Downloads/MORT.dta", replace

*------
import delimited "/Users/patrickpoleshuk/Downloads/API_SP.DYN.LE00.IN_DS2_en_csv_v2_1495206/API_SP.DYN.LE00.IN_DS2_en_csv_v2_1495206.csv", encoding(UTF-8) clear 

forvalues x=5(1)64{
local y= `x' +1955
rename v`x' LIFE`y'
}

* Given that a country's general health is a strong indicator of its economic development, I included a variable which measures "Life Expectancy At Birth" (in years.). As the people are becoming healthier, foreign investment optimism may increase. 

rename v1 countryname
drop v65 v66 v3 v4 v2
reshape long LIFE, i(countryname) j(year)
sort countryname year
save "/Users/patrickpoleshuk/Downloads/LIFE.dta", replace

*------
import delimited "/Users/patrickpoleshuk/Downloads/API_SI.POV.GINI_DS2_en_csv_v2_1495229/API_SI.POV.GINI_DS2_en_csv_v2_1495229.csv", encoding(UTF-8) clear 

forvalues x=5(1)64{
local y= `x' +1955
rename v`x' GINI`y'
}

* GINI stands for the Gini Index (or coefficent), as estimated by the World Bank. Simply put, it is a measure of inequality of income within a country. If the GINI variable is 0, there is perfect equality of income, and if there exists perfect inequality, the GINI variable would be 1 (100% here given that they spread the index out from 0% to 100% in this dataset). Both of these cases are pragmatically impossible, so it realistically is going to be dispersed around 50%. Personally, I believe that a higher GINI coefficent can both be good and bad for FDI inflows. A higher Gini index, while indicating higher inequality, could signal that that the country has adopted more inclusive market institutions, which take advantage of the entrepreneurial talents of the people, and thus a higher percentage of the country's wealth is concentrated within these successful groups of entrepreneurs. On the other hand, it could be a harbinger for political elite corruption, where some variety of extractive market institutions are in play to perpetuate the wealth of a ruling class. Thus, it is hard to say what the effect will be on FDI in either case. 

rename v1 countryname
drop v65 v66 v3 v4 v2
reshape long GINI, i(countryname) j(year)
sort countryname year
save "/Users/patrickpoleshuk/Downloads/GINI.dta", replace
sum GINI

*-------

import delimited "/Users/patrickpoleshuk/Downloads/API_BX.KLT.DINV.CD.WD_DS2_en_csv_v2_1495714 2/API_BX.KLT.DINV.CD.WD_DS2_en_csv_v2_1495714.csv", encoding(UTF-8) clear 

forvalues x=5(1)64{
local y= `x' +1955
rename v`x' FDI`y'
}

* Foreign direct investment is any investment made by a firm or individual in one country into business interests located in another country. In this dataset it is denominated in USD, and will serve as the dependent variable all future regression analysis.

rename v1 countryname
drop v65 v66 v3 v4 v2
reshape long FDI, i(countryname) j(year)
sort countryname year
save "/Users/patrickpoleshuk/Downloads/FDI.dta", replace

*-------

import delimited "/Users/patrickpoleshuk/Desktop/API_SI.POV.DDAY_DS2_en_csv_v2_889325.csv", encoding(UTF-8) clear 

forvalues x=5(1)64{
local y= `x' +1955
rename v`x' POVERTY`y'
}

* POVERTY is the "Poverty Headcount Ratio At $1.90 A Day (2011 PPP) (% of population)". This is currently the indicator that one is living in extreme poverty, and we can certainly predict that the more impoverished a country is at baseline, the less optimistic foreign investors will be in realizing the rapidity of that country's growth prospects. 

rename v1 countryname
drop v65 v3 v4 v2
reshape long POVERTY, i(countryname) j(year)
sort countryname year
save "/Users/patrickpoleshuk/Downloads/POVERTY.dta", replace

*-------

import delimited "/Users/patrickpoleshuk/Desktop/API_EG.ELC.ACCS.ZS_DS2_en_csv_v2_889816.csv", encoding(UTF-8) clear 

forvalues x=5(1)64{
local y= `x' +1955
rename v`x' ENERGY`y'
}

* ENERGY is a variable I use to indicate how robust the infrastructure of a country is. It measures what percent of the total population has access to electricity, and we could assume that if the infrastructure grows stronger so will foreign investment into it. 

rename v1 countryname
drop v65 v3 v4 v2
reshape long ENERGY, i(countryname) j(year)
sort countryname year
save "/Users/patrickpoleshuk/Downloads/ENERGY.dta", replace

*-------

import delimited "/Users/patrickpoleshuk/Desktop/API_SE.ADT.1524.LT.ZS_DS2_en_csv_v2_892176.csv", encoding(UTF-8) clear 

forvalues x=5(1)64{
local y= `x' +1955
rename v`x' LITERACY`y'
}

* LITERACY is a variable that measures "Literacy Rate, Youth Total (% of people ages 15-24)". Although we may predict that there could be multicollinearity between this variable and SCHOOL, we could still predict, without conducting any analysis yet, that foreign investors would have more confidence investing their money in a country with a more educated populace. 

rename v1 countryname
drop v65 v3 v4 v2
reshape long LITERACY, i(countryname) j(year)
sort countryname year
save "/Users/patrickpoleshuk/Downloads/LITERACY.dta", replace

*-------
 import delimited "/Users/patrickpoleshuk/Downloads/API_NY.GDP.MKTP.CD_DS2_en_csv_v2_1495053/API_NY.GDP.MKTP.CD_DS2_en_csv_v2_1495053.csv", encoding(UTF-8) clear 

forvalues x=5(1)64{
local y= `x'+1955
rename v`x' GDP`y'
}

* GDP, to mention again, is the monetary value of all goods and services produced within a country in a specific time-frame (in this case it's every year).
rename v1 countryname
drop v65 v3 v4 v2
reshape long GDP, i(countryname) j(year)
sort countryname year
save "/Users/patrickpoleshuk/Downloads/GDP.dta", replace

*--------

import delimited "/Users/patrickpoleshuk/Desktop/API_VC.IHR.PSRC.P5_DS2_en_csv_v2_422503.csv", clear 

forvalues x=5(1)64{
local y= `x'+1955
rename v`x' CRIME`y'
}

* CRIME measures the Intentional Homicides rate (per 100,000 people). As mentioned above, this seems to be a growing trend within some countries in Latin America, and within larger cities in the U.S, so I wanted to test whether it had a signficant effect on a country's ability to affect FDI flows.

rename v1 countryname
drop v65 v3 v4 v2
reshape long CRIME, i(countryname) j(year)
sort countryname year
save "/Users/patrickpoleshuk/Downloads/CRIME.dta", replace

*--------

import delimited "/Users/patrickpoleshuk/Desktop/API_PA.NUS.FCRF_DS2_en_csv_v2_888121.csv", encoding(UTF-8) clear 

forvalues x=5(1)64{
local y= `x'+1955
rename v`x' EXCHANGE`y'
}

* EXCHANGE measures the Official Exchange Rate (where it measures the total amount of local currency needed to purchase 1 USD), for the yearly average. You will later see that I will be converting this varibale into log format, as it would be much more useful to interpret a currency appreciating or depreciating against the USD by a given percent. 

rename v1 countryname
drop v65 v3 v4 v2
reshape long EXCHANGE, i(countryname) j(year)
sort countryname year
save "/Users/patrickpoleshuk/Downloads/EXCHANGE.dta", replace

*--------

import delimited "/Users/patrickpoleshuk/Downloads/API_IC.BUS.DFRN.XQ_DS2_en_csv_v2_1571281/API_IC.BUS.DFRN.XQ_DS2_en_csv_v2_1571281.csv", encoding(UTF-8) clear 


forvalues x=5(1)64{
local y= `x'+1955
rename v`x' EASE`y'
}
* EASE is the measure of the "Ease of Doing Business Score (0 = lowest performance to 100 = best performance). Like the varibale LEGAL, this variable attemps to control for the degree of inclusive market institutions within a given country. LEGAL tries to account for strong tangible property rights, intellectual property rights, and fair judicial processes, among many other things, while EASE attempts to determine how business friendly a country is. For example, areas such as Peru, while developing rapidly, have fostered somewhat of a negative reputation as an area where legal businesses are seldom practiced. This is due to overwhelming amount of bribes and permits needed for one to operate legally in the country. This comes with drawbacks, however, given that their business is illegal they are unable to adquire capital to expand their operations; one can only go so far when operating an illegal business. 

rename v1 countryname
drop v65 v3 v4 v2
reshape long EASE, i(countryname) j(year)
sort countryname year
save "/Users/patrickpoleshuk/Downloads/EASE.dta", replace
*--------

import delimited "/Users/patrickpoleshuk/Downloads/API_IC.TAX.TOTL.CP.ZS_DS2_en_csv_v2_1568104/API_IC.TAX.TOTL.CP.ZS_DS2_en_csv_v2_1568104.csv", encoding(UTF-8) clear 

forvalues x=5(1)64{
local y= `x'+1955
rename v`x' TAX`y'
}

* Here is our last control variable, it is the "Total Tax And Contribution Rate" (as a % of total profit). Naturally, a tax is a disincentive on consumption and investment within and outside a country's borders. If larger portions of profit resulting from FDI are compromised with, as say a higher capital gains tax, then we can expect a negative coefficent effect of TAX on FDI. 

rename v1 countryname
drop v65 v3 v4 v2
reshape long TAX, i(countryname) j(year)
sort countryname year
save "/Users/patrickpoleshuk/Downloads/TAX.dta", replace

use "/Users/patrickpoleshuk/Downloads/FDI.dta", clear
merge 1:1 countryname year using "/Users/patrickpoleshuk/Downloads/GDP.dta"
keep if _merge ==3
drop _merge 

merge 1:1 countryname year using "/Users/patrickpoleshuk/Downloads/DEBT.dta"
keep if _merge ==3
drop _merge 

merge 1:1 countryname year using "/Users/patrickpoleshuk/Downloads/EASE.dta"
keep if _merge ==3
drop _merge 

merge 1:1 countryname year using "/Users/patrickpoleshuk/Downloads/TAX.dta"
keep if _merge ==3
drop _merge 

merge 1:1 countryname year using "/Users/patrickpoleshuk/Downloads/LIFE.dta"
keep if _merge ==3
drop _merge 

merge 1:1 countryname year using "/Users/patrickpoleshuk/Downloads/SCHOOL.dta"
keep if _merge ==3
drop _merge 

merge 1:1 countryname year using "/Users/patrickpoleshuk/Downloads/CRIME.dta"
keep if _merge ==3
drop _merge 

merge 1:1 countryname year using "/Users/patrickpoleshuk/Downloads/MORT.dta"
keep if _merge ==3
drop _merge 

merge 1:1 countryname year using "/Users/patrickpoleshuk/Downloads/ENERGY.dta"
keep if _merge ==3
drop _merge 

merge 1:1 countryname year using "/Users/patrickpoleshuk/Downloads/LEGAL.dta"
keep if _merge ==3
drop _merge 

merge 1:1 countryname year using "/Users/patrickpoleshuk/Downloads/POVERTY.dta"
keep if _merge ==3
drop _merge 

merge 1:1 countryname year using "/Users/patrickpoleshuk/Downloads/GINI.dta"
keep if _merge ==3
drop _merge 

merge 1:1 countryname year using "/Users/patrickpoleshuk/Downloads/ELEC.dta"
keep if _merge ==3
drop _merge 

merge 1:1 countryname year using "/Users/patrickpoleshuk/Downloads/LITERACY.dta"
keep if _merge ==3
drop _merge 

merge 1:1 countryname year using "/Users/patrickpoleshuk/Downloads/EXCHANGE.dta"
keep if _merge ==3
drop _merge 

keep if countryname == "Mexico" | countryname == "United States" | countryname=="Nicaragua" | countryname=="Guatemala" | countryname=="Venezuela" | countryname=="Chile" | countryname=="Brazil" | countryname==" Colombia"| countryname=="Argentina" | countryname=="Ecuador" | countryname=="Cuba" | countryname=="Bolivia" | countryname=="Haiti" | countryname=="Dominican Republic" | countryname=="Honduras" | countryname=="Paraguay" | countryname=="El Salvador" | countryname=="Costa Rica" | countryname=="Panama" | countryname=="Puerto Rico" | countryname=="Uruguay" | countryname=="Guadeloupe"| countryname=="Martinique" | countryname=="French Guiana" | countryname=="Saint Kitts and Nevis" | countryname=="Dominica" | countryname=="Antigua and Barbuda" | countryname=="Grenada" | countryname=="Saint Vincent and the Grenadines" | countryname=="Saint Lucia" | countryname=="Barbados" | countryname=="Trinidad and Tobago" | countryname=="Bahamas" | countryname=="Suriname" | countryname=="Guyana" | countryname=="Jamaica" | countryname=="Belize" | countryname=="Peru"

save "/Users/patrickpoleshuk/Downloads/Final.dta", replace

keep if year >= 1960
* I'll be keeping data from all years in the data frame, for the sake of perserving high statistically signficant variables. 
drop if year >= 2019
* This is the highest year that data is currently collected at.

* ssc install asdoc
* I will be using this package in the future to translate some of my regression tables and graphs into a word format. 

sum GDP, d
gen HIGDP = (GDP >  1.57e+10) 
ttest FDI, by(HIGDP)

* Before regressing any of our variables we can already see that a higher Gross Domestic Product value will be associated with a signficant change in Foreign Direct Investment. 
* We reject the null hypothesis that having a country with an above average GDP can draw in FDI at the same rate that a country with below average GDP at the 1%, 5%, and 10% signficant levels. This is reflected in our t-value of -8.9901. 

regress FDI GDP, robust 
* If we want to run a simple linear regression with FDI as our dependent variable and GDP as our independent variable, we will need to modify our variables. We can see that, without converting our varibales into a log format, this a little inconvenient to interpret; we are also left with a statistically insignificant intercept value. If we were to interpret this regression, we could see that for every $1 increase in GDP value, FDI will go up by roughly $.0176. 
gen lnFDI = ln(FDI)
gen lnGDP = ln(GDP)
* I will be converting all my large numerical variables into a log format, and, as you will see, many of my explanatory variables as well. 
reg lnFDI lnGDP, robust
* Now we have an intercept value that is statistically signficant at the 1%, 5%, and 10% signficant levels. We can also see that for every 1% increase in Gross Domestic Product, there is going to be a .9347046% increase in Foreign Direct Investment. 
display e(r2_a) 
* The coefficent of determination (r^2 value) will determine the "goodness of fit", essentially how well our regression model predicts future observations. In other words, the r^2 value is a measure of how well a variance in our independent variable predicts a variance in our dependent variable. We can see from a r^2 value of roughly .7718, that a variance in GDP explains roughly 77.18% of a variance in FDI. 
*graph twoway (lfitci lnFDI lnGDP) (scatter lnFDI lnGDP)
* Here is graphical representation of my regression. 
reg lnFDI lnGDP, r
predict resid, residuals
* One common way to test the strength of our regression is to plot the residual deviation from the predicted values in our regression slope. If the observed value deviate from our predicted values in a non-random order, we can claim that there is some bias that the simple linear regression, with log transformations, is ignoring.
gen time = _n
line resid time, yline(0)
scatter resid time, yline(0)
* Fortunately, in both residual plots, one where we use scatter plot observations and one where we use a line plot, we can see random, unbiased variation of the residuals in the regression. In other words, our observed variables don't gear off into an unexplained pattern outside of our regression slope. 

* To explain the value of adding ", robust" at the end of our regression, we can see that without the command our standard errors (and thus our signficant levels) are altered. We will also that this regression is going to be biased, as it fails the heteroskedasticity test. Since we reject the null hypothesis, at the 1% level, of equal variance between residuals, we can say that these residuals are not homoskedastic and biased. 
reg lnFDI lnGDP, r
reg lnFDI lnGDP
*hettest

* Now, moving onto testing for control variables, we need to be very careful on what we add to the regression. Firstly, we run into a clear problem if we try to add all the control variables into the regression at once. 
* reg lnFDI lnGDP GINI POVERTY EXCHANGE LIFE MORT SCHOOL DEBT CRIME ENERGY LIT TAX LEGAL ELEC EASE, r
* There are no observations. This means that there are no cells in my data frame where there is an observation made for all of these 16 variables at once. This is understandable, but it is clear that at least one of my variables must not have of many observations attched to it from the beginning. 
* It's clear that I need to delete at least one of my variables of interest, so I want to strategically do so without losing much explanatory power. 

cor lnFDI DEBT
* Here we see that the Debt to GDP ratio has a very weak negative linear relationship with our dependent variable, so we may be able to eliminate it without much issue. 
sum LITERACY
sum SCHOOL
cor LITERACY SCHOOL
* We can also see that for literacy rate data there are only 204 observations across all 38 countries, in contrast to over triple that amount for SCHOOL. And given that it is correlated with the variable SCHOOL at a coefficent value of .6976, this explanatory variable would be best left out. 
cor ELEC lnGDP
* We can also see that % change in GDP is strongly positively correlated with total per capita electricity consumption at a coefficent value of .7014. We should eliminate this variable, as it would appear superfluous in its explanatory power and won't allow the regression to run properly. 

* Although I imported a wide variety of control variables, I knew that some of them will definitely be extraneous and if we were to add all of these predictor variables, minus the ones just mentioned, into the regression at the same time, we would end up with a biased regression and unreliable coefficent of effects for our explanatory variables. Here I will show an example of this by simple running a mutliple linear regression with all of our variables in it.  
* After eliminating these variables we end up with this: 
reg lnFDI lnGDP GINI POVERTY EXCHANGE LIFE MORT SCHOOL CRIME ENERGY TAX LEGAL EASE, r
* While nothing was automatically eliminated due to collinearity, we can definitely do better in controlling for endogeneity bias. First off all, the only variable that is statistically signficant at the 1% level is lnGDP, and no other coefficent is statistically signficant even at the 10% level. Secondly, some of these coefficents of effects don't logically make sense, as with for example the % change in mortality rates having a positive effect on FDI.

* Before going any further I want to transform some my variables into log values. 
gen lnLIFE = ln(LIFE)
gen lnMORT = ln(MORT)
gen lnCRIME = ln(CRIME)
* I transformed some my rate variables so now they will represent percents in the regression interpretation. 

reg lnFDI lnGDP GINI POVERTY EXCHANGE lnLIFE lnMORT SCHOOL lnCRIME ENERGY LIT TAX LEGAL EASE
vif
* Multicollinearity occurs when different explanatory variables in our regression are linearly related with each other, obfuscating some of the predictive power of our variables. 
* Lets try to control for multicollinearity within the regression. The command, "vif", stands for the Variance Inflation Factor and is a good measure of the multicollinearity in a set of mutliple regression variables. Under a case with zero multicollinearity the vif value would be 0, and any vif value below 3 is considered to be problematic; these vif values are certainly problematic. The mean vif value is 107.62! The lowest one still being problematic at 10.94. We must omit at least a couple of these variables in order for them to not give biased effect results. 

ssc install ridgereg
* We can see that there are erros with multicollinearity within my regression, so we are going to have to attempt to control for that with a ridge regression, which accounts for a small bias factor in my explanatory coefficents to offset potential problems with collinearity. First, we need to run a multicollinearity test, to attempt to determine which variables are the most influential in obfuscating the effects of others. 
* If kr(0) in ridge(orr, grr1, grr2, grr3), the model will be an OLS regression model(orr) : Ordinary Ridge Regression. 

set matsize 800, permanently
* We need to expand our matrix size, to handle the number of observations coming in for our analysis. 

ridgereg lnFDI lnGDP GINI POVERTY EXCHANGE lnLIFE lnMORT SCHOOL lnCRIME ENERGY LIT TAX LEGAL EASE, model(orr) kr(0) diag lmcol mfx(lin)

* The Farrar – Glauber (F.G.) test is considered to be the best examination of multicollinearity. The F.G. test consists of three part: a determinant test, a multicollinearity F-test, and a multicollinearity T-test. In the first test, if the determinant of the correlation matrix for our independent variables is zero, there is undeniable multicollinearity. This is the case. To explain, in case of perfect multicollinearity the simple correlation coefficients are 1 to unity and so the above determinant turns to zero. That is, a matrix of all ones is going to equate to a determinate of 0, and the system of equations associated with it is linearly dependent. Now on the other hand, in case of orthogonality (statistical independence) of the explanatory variables the simple correlation coefficients are all equal to zero and so the standardized determinant turns to unity. That is, the determinant is 1. 

* In the second test, we are essentially testing for the statistical significance of these multiple correlation coefficients using an F test. What we find here is that for the vif and F-test value, they are the highest at lnLIFE which implies a high degree of explanatory correlation between its effect and the lnMORT effect on FDI. This is also the case with GINI and POVERTY and LIFE and EASE, as reinforced by the third test as well. At the third part of the testing, the partial correlation determined by the T-test value is at its highest, implying the greatest satistical signficance, when "lnMORT" is paired with "lnLIFE", and "GINI" is paired with "POVERTY". 

* Given the ridge regression test results, I will be eliminating one variable from each of these three correlated pairs. I choose POVERTY ovr GINI because I believe GINI has less explanatory power on our dependent variable; I choose EASE over LEGAL for that very same reason, and I chose lnLIFE over lnMORT because life expectancy is part of the calculation of the HDI Index while lnMORT is not. 
* Really we can go about many ways of running a regression with these different control variables, as long as they don't correlate with each other to a large degree. 

reg lnFDI lnGDP lnLIFE SCHOOL EXCHANGE TAX EASE POVERTY lnCRIME, r
vif
* Notice how our regression still, however, lacks statistical signficance. Given that the vif value is at its highest at the variable SCHOOL, at 5.05, we can eliminate it as it seems to be still somewhat correlated with the other variables. 

ssc install outreg2
* The outreg2 package allows us to examine different varieties of regression tables. 
* I don't control for lnCRIME in any of these estimators because I believe it is best saved as an estimator for until after we control for fixed-effects. 
reg lnFDI lnGDP lnMORT EXCHANGE EASE, r
est store model1
* In this model, with every 1% increase in GDP there is going to be roughly a .816% increase in FDI. With every 1 currency unit increase in LCU with regards to USD, FDI will go down by -.00015%; this signfies that FDI has a negative impact on a depreciating currency. A 1% change in the infant mortality rate, will signal roughly a -.330% decrease in FDI. Lastly, as the ease of conducting business index increases by 1 unit, there will be a predicted .01889% increase in FDI. 
reg lnFDI lnGDP lnLIFE LEGAL GINI EXCHANGE TAX, r
est store model2
* In this model, I use lnLIFE instead of lnMORT and LEGAL instead of EASE; I also add in a tax and Gini variable condition. A 1% increase in GDP is associated with roughly a .884% increase in FDI. A 1% change in the life expectancy of citizens within a country is associated with a 6.06% increase in FDI. As the legal rights index increases by 1 unit, FDI will increase by .052%. For every 1% increase in the Gini index there will be roughly a .08% increase in FDI. With every 1 currency unit increase in LCU with regards to USD, FDI will go down by -.00017%. Lastly, our only non-statistically signficant varibale, TAX, predicts that for every 1% increase in tax rate, as a % of total profit, FDI will decrease by -.000067%. 
reg lnFDI lnGDP lnLIFE EXCHANGE POVERTY EASE TAX, r
est store model3
* In this model I use EASE instead of LEGAL, and POVERTY instead of GINI. For every 1% increase in GDP, there will be roughly a .948% increase in FDI. For every 1% increase in life expectancy there will be a 7.25% increase in FDI. With every 1 currency unit increase in LCU with regards to USD, FDI will go down by -.00010%. For every 1% increase in tax rate, as a % of total profit, FDI will decrease by -.00203% (this is still a statistically insignificant variable). For every 1 increase in the ease of doing business index, there will be roughly a .031% in FDI (this variable is now statistically insignificant, probably as a result of the tax condition being added). Lastly, for every 1% increase in the population living under extreme poverty, there will be roughly a .051% increase in FDI. This doesn’t seem to make any sense, and when we factor in fixed effects, we will see that this variable is no longer statistically significant. 

outreg2 [model1 model2 model3] using tableOLS, word replace dec(5) label symbol(***,**,*,---) alpha(.01,0.05,0.1,.15)
* Here is the completed OLS table of effect estimators on FDI. We can see that TAX is the only variable which is insignificant in both cases where it is presented, I will try to determine if it's useful the following regression. 

ssc install elasticregress
* I will also be using an elastic-net regression to see if any other of my variables are extraneous. 
* An elastic-net regression applies both the constraints of the ridge regression and LASSO (least absolute shrinkage and selection operator) on our OLS estimate. By itself LASSO regression tends to shrink all correlated terms to 0 and pick only one of the correlated parameters. Ridge regression, as we've seen, tends to shrink all of the parameters for the correlated variables together. It is introducing a bias to account for a better OLS prediction. In elastic-net regression we will be shrinking all the parameters associated with the correlated variables and shrinking any coefficents to 0 if they are not pertinent to the regression. Thus, it does the best job of dealing with correlated coefficents on our dependent variable. 

elasticregress lnFDI lnGDP POVERTY EXCHANGE lnLIFE TAX EASE
* asdoc elasticregress lnFDI lnGDP POVERTY EXCHANGE lnLIFE TAX EASE, append
* There are no statistically significance notifications for my coefficents, given that, in elastic-net regressions, we are putting a regularization on our coefficents and already shrinking non-significant values to zero. Any non-zero effect in our coefficents, as seen for all of them except TAX, implies that they are alreay statistically significant. While it might seem bizarre that we have a positive effect coefficent for POVERTY, we will be controlling for yearly fixed effects in our panel data which attempts to provide a more accurate reading of our coefficents later on. 

* The alpha in this equation is the degree of mixing between the LASSO and Ridge characteristics. Given that none of my variables can really be considered "useless" the ridge regression would be more applicable for my data. Indeed, if alpha = 1 than the elastic-net is mostly made of the ridge parameter added bias, while if lambda is equal to 1 than the regression is primarly concerned with shrinking any correlated coefficents to 0. This elastic-net shares more characteristics with the ridge regression than the LASSO, as the alpha value is .4. Yet, we can see that the shrinkage parameter, lambda, is .0819, and we had SCHOOL shrunk down. 

reg lnFDI lnGDP EXCHANGE POVERTY lnLIFE EASE, r
* Currently we are left with this regression, where are arn't lacking any major statistical signficance. However, I will attempt to make my estimators more precise, going into my time series analysis. 

* While I've made sure to control for multicollinearity, insignificant coefficents, and eliminate variables with small samples, I haven't controlled for the possibility of lagged effects or time-invariant unobserved individual characteristics, across countries and years, that can be correlated with our current independent variables.
* It is generally always important to control for year effects in our regression, as it takes into account aggregate rising trends that would either inflate or deflate our coefficent of effects on our explanatory variables.
* First however, we need to determine whether we will be using random effects or fixed effects regression. I have a feeling we will be using fixed effects, but we can test for this in the following lines. 

gen lnEXCHANGE = ln(EXCHANGE)
* I found that the standard EXCHANGE varibale is best under a standard OLS estimator, as taking the log of this rate introduces weak statistical signficance. I theorize that this might be because without controlling for fixed effects, we arn't taking into account the lagged effects of the exchange rates on FDI. In other words, investors won't respond to a 1% increase or decrease in exchange rate appreciation immediately. They will take some time to alter their FDI in response to this change, so the standard OLS estimate will better pick up a 1 unit appreciation or depreciation in LCU against the USD rather than a 1% increase or decrease.
egen countryname1 = group(country)
xtset countryname1 year, yearly
xtreg lnFDI lnGDP lnEXCHANGE lnLIFE lnCRIME, fe
est store fe

xtreg lnFDI lnGDP lnEXCHANGE lnLIFE lnCRIME, re
est store re

hausman fe re

* Notice that I eliminated the variable EASE, given that there are very little observations and for time series analysis we need to analyze variables for each given year. There was simply not enough observations under EASE, nevertheless we can see that, under the Hausman test we can reject the null hypothesis that we will be using a random effects model. 
xtreg lnFDI lnGDP lnEXCHANGE lnLIFE lnCRIME POVERTY
* We get weak statistical signficance for lnCRIME which I believe to be contributed to the POVERTY variable. Given that POVERTY has a positive effect on FDI, I feel that it is also best eliminated.  
xtreg lnFDI lnGDP lnLIFE lnEXCHANGE lnCRIME, fe
* This is the ideal regression estimator. It might appear a little bizzare that lnEXCHANGE now has a positive effect on FDI, however, after controlling for yearly fixed effects, it would make sense that foreign investors would prefer a country whose currency is already constantly in demand, as a higher demand for a country's currency signals that the value of their goods on the world market may be higher than before.  
xtreg lnFDI lnGDP lnEXCHANGE lnLIFE lnCRIME, fe
* asdoc xtreg lnFDI lnGDP lnEXCHANGE lnLIFE lnCRIME, fe
* With our new model controlling for fixed effects, we use the "within" r^2 value which is .6055. Notice how the coefficient of effects have changed somewhat significantly. 
* When working with any panel data I think it's a useful idea to control for aggregate trends throughout the years that may have affected my coefficent results.
* Additionally, if I had strong belief that my regression suffered from reverse causality. Essentially, an increasing FDI would cause a greater GDP to be produced, as with the worry that a continuous increase in FDI would lead to an increase in GDP, then I could use instrumental variables. However, for now, I am more worried about Foreign Direct Investment taking off and injecting the economy with new growth, not detected under standard OLS predictions. I believe fixed effects is the best way to control for this. 

* In these loops I will try to provide evidence of varying effects in my variables throughout various years. 
gen t = _n
* Here I am numbering each row of cells. 
ssc install coefplot
foreach i of num 1122/1180{
reg lnFDI lnGDP if t>`i' & t<`i' + 1180
est store reg_`i'
 }
* In this loop, I am running 58 regressions corresponding to each year, to see whether the coefficent of effect has changed at all during the years. I only did it for these specific years, because Stata and my computer would not be able to load that many regressions all at once, and I really only need to prove that the effect changes throughout the years by using one country with 1960-2018 observations. Here, I chose the time statement for the country of Mexico for these 58 years. 
coefplot reg_*, drop(_cons) nokey 
* Here we are determining whether the relationship of lnGDP on lnFDI has changed in way where there might be some unobserved heterogeneity present as some unobserved variables may be correlated with either our FDI or GDP value. We can see, in part, this is true as there is some sort of shift between the effect of lnGDP on lnFDI throughout the years. The fixed effect models attempts to control for these individual characteristic effects. 

foreach i of num 1181/1239{
reg lnFDI lnGDP if t>`i' & t<`i' + 1239
est store regex_`i'
 }
coefplot regex_*, drop(_cons) nokey 
* Here we can conduct the same type of test with another country, Panama. 
* We see lagged effects of GDP growth on FDI, where foreign investors don't start altering their FDI in response to GDP growth until what seems to be near the end of the 1980's or early 1990's. 

reg lnFDI lnGDP, r
est store model4
* Here is the original simple linear regression, where a 1% increase in GDP is associated with a .9347% increase in FDI. 
reg lnFDI lnGDP EXCHANGE POVERTY lnLIFE EASE, r
est store model5
* Here is a multiple linear regression where I believe we have sufficiently controlled for multicollinearity. This is the same as our "model3" but without a tax condition. The only problem I see here is with the variable, POVERTY, having a statistically signficant positive effect on FDI. This is not the case, however, in the fixed-effects model, and I had to discard it as it was not statistically signficant in that case.
xtreg lnFDI lnGDP lnLIFE lnEXCHANGE lnCRIME, fe
est store model6
* Here is the most precise I could make my estimators. To run a regression like this, we need variables with a every large sample size as we are comparing results across different years. In this model a 1% increase in GDP predicts a 1.12487% increase in FDI. A 1% increase in life expectancy predicts roughly a 7.53% increase in FDI. Interestingly, a 1% increase in LCU against USD (a 1% increase in depreciation) results in a .19945% increase in FDI. This makes more sense than in our OLS estimate, because, while foreign investors desire a strong stable currency, the depreciating currency results in a cheaper investment overall. Thus we can say, in our fixed-effects model, that a depreciating currency incentivizes Foreign Direct Investment into a country. Lastly, a 1% increase in the Homicide Rate (per 100,000 people) results in a -.15846% increase in FDI. This is not surprising, as greater in-country violence may cast doubt in the development potential of a country. 

outreg2 [model4 model5 model6] using tableF, word replace dec(5) label symbol(***,**,*,---) alpha(.01,0.05,0.1,.15)

* As one final bit of analysis we can see, graphically, how our certain independent variables have progressed over the years within a given country. We can't use our entire data set of all countries, as there are too many observations to show a coherent graph trend. I will use Mexico, however, we could really use any country in the dataset. 

keep if countryname == "Mexico"

graph twoway connected lnFDI lnGDP t
* asdoc graph twoway connected lnFDI lnGDP t
* Here is the graphical representation of how the log values of FDI and GDP have progressed over the last 58 years. 
graph twoway connected lnFDI lnGDP EXCHANGE POVERTY lnLIFE lnCRIME t
* asdoc graph twoway connected lnFDI lnGDP EXCHANGE POVERTY lnLIFE lnCRIME t
* This is the graphical representation of how some of our valid control variables have changed over our observed period.  

* To conclude, after controlling for the possiblity of lagged effects, unobserved heterogeneity and individual aggregate trends, multicollinearity, and statistical signficance, we are only left with a handful of variables. What we can say, from our "model6", is that there is a definite positive relationship with a growing economy and foreign direct investment. Additionally, there is negative impact of violence, a positive effect of health, and a positive effect of a depreciating exchange rate on a country's foreign tangible investment. From these observations we can predict that for these Latin American countries, along with the United States, if health is not improved, if economic growth is not continuous, if local currencies are overvalued on the world market, and if homicide rates increase, foreign confidence in the growth prospects of these countries will decline. 
log close
