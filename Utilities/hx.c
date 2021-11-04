#include<stdio.h>
#include<string.h>
double hx(double tCold,double tHot,double mRateCold, double mRateHot,double pressureCold, double pressureHot,double densityCold,double densityHot, double tempOut[2], double pressOut[2])
{
double tColdF,tHotF;
double pColdF, pHotF;
char tColdS[50],tHotS[50],mRateColdS[50],mRateHotS[50], pressureColdS[50], pressureHotS[50],densityColdS[50],densityHotS[50];


//char runner[500] = "sudo /home/ubuntu/hx/runnerDocker.sh";
//char logFile[] =" > /home/ubuntu/hx/out.txt";
//#define outFile "/home/ubuntu/hx/out.txt"
//#define logRunFile "/home/ubuntu/hx/log.txt"

char runner[500] = "sudo /home/ubuntu/hx/runnerDocker.sh";
char logFile[] =" > /home/ubuntu/hx/out.txt";
#define outFile "/home/ubuntu/hx/out.txt"
#define logRunFile "/home/ubuntu/hx/log.txt"

FILE *file;
sprintf(tColdS," %lf ",tCold);
sprintf(tHotS," %lf ",tHot);
sprintf(mRateColdS," %lf ",mRateCold/10.);
sprintf(mRateHotS," %lf ",mRateHot/10.);
sprintf(pressureColdS," %lf ",pressureCold*100000.);
sprintf(pressureHotS," %lf ",pressureHot*100000.);
sprintf(densityColdS," %lf ",densityCold);
sprintf(densityHotS," %lf ",densityHot);

strcat(runner, tColdS);
strcat(runner, tHotS);
strcat(runner, mRateColdS);
strcat(runner, mRateHotS);
strcat(runner, pressureColdS);
strcat(runner, pressureHotS);



strcat(runner, logFile);
file = fopen(logRunFile,"a");
fprintf(file,"%s\n",runner);
fclose(file);
system(runner);

file = fopen(outFile,"r");
fscanf(file, "%lf %lf %lf %lf ",&tColdF,&tHotF,&pColdF,&pHotF);
tempOut[0] = tColdF;
tempOut[1] = tHotF;
pressOut[0] = pColdF;
pressOut[1] = pHotF;
fclose(file);
return 0;
}
