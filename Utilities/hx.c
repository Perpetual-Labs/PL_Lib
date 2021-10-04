#include<stdio.h>
#include<string.h>

double hx(double tCold,double tHot,double mRateCold, double mRateHot,double densityCold,double densityHot, double tempOut[2], double pressOut[2])
{
double tColdF,tHotF;
double pColdF, pHotF;
char tColdS[50],tHotS[50],mRateColdS[50],mRateHotS[50],densityColdS[50],densityHotS[50];


char runner[500] = "/home/openmodelica/hx/runnerDocker.sh";
char logFile[] =" > /home/openmodelica/hx/out.txt";
#define outFile "/home/openmodelica/hx/out.txt"


FILE *file;
sprintf(tColdS," %lf ",tCold);
sprintf(tHotS," %lf ",tHot);
sprintf(mRateColdS," %lf ",mRateCold);
sprintf(mRateHotS," %lf ",mRateHot);
sprintf(densityColdS," %lf ",densityCold);
sprintf(densityHotS," %lf ",densityHot);

strcat(runner, tColdS);
strcat(runner, tHotS);
strcat(runner, mRateColdS);
strcat(runner, mRateHotS);
strcat(runner, densityColdS);
strcat(runner, densityHotS);

strcat(runner, logFile);
file = fopen("/home/openmodelica/hx/log.txt" ,"a");
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
