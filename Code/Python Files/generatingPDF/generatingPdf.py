
#Creating a pdf in python of the matlab code

import os
import csv

def totalFunction(): #Need this function because we need region
    infile = open('finalTable.csv','r')
    changeToGitDir()
    outfile = open('genFile.csv','w')
    i = 0
    for line in infile:
        line = line.rstrip('\n')
        temp = line.split(',')
        if i == 0:
            temp[1] = "Class"
            temp[2] = "Name"
            temp[4] = "InState"
            temp[5] = "Total"
            for elem in range(len(temp)):
                outfile.write(str(temp[elem]))
                outfile.write(",")            
        else:
            if temp[1] == 'NaN':
                temp[1] = "N/"
            if temp[2] == 'Trinity (Louisville)':
                temp[2] = 'Trinity'
            if temp[2] == 'Holy Cross (Louisville)':
                temp[2] = "Holy Cross - Louisville"
            if temp[2] == "Holy Cross (Covington)":
                temp[2] = "Holy Cross - Covington"       
            for elem in range(len(temp)):
                if elem == 4 or elem == 5:
                    outfile.write("" + temp[elem])
                    outfile.write(",")
                else:
                    outfile.write(str(temp[elem]))
                    outfile.write(",")
        outfile.write('\n')
        i = i+1
    outfile.close()
    os.chdir('../../')
    os.chdir('Google Drive (jackson.norris@centre.edu)/Summer 2019 Research/MATLAB/Football/2019/ratings')
    infile.close()
    return

def singleFunction(inString,outString): #Need this function because 
    infile = open(inString,'r')#inString
    changeToGitDir()
    outfile = open(outString,'w')#outString
    i = 0
    for line in infile:
        line = line.rstrip('\n')
        temp = line.split(',')
        if i == 0:
            temp[1] = "Name"
            temp[3] = "InState"
            temp[4] = "Total"
            for elem in range(len(temp)):
                outfile.write(str(temp[elem]))
                outfile.write(",")            
        else:
            if temp[1] == 'Trinity (Louisville)':
                temp[1] = 'Trinity'
            if temp[1] == 'Holy Cross (Louisville)':
                temp[1] = "Holy Cross - Louisville"
            if temp[1] == "Holy Cross (Covington)":
                temp[1] = "Holy Cross - Covington" 
            for elem in range(len(temp)):
                if elem == 3 or elem == 4:
                    outfile.write("" + temp[elem])
                    outfile.write(",")
                else:
                    outfile.write(str(temp[elem]))
                    outfile.write(",")

        outfile.write('\n')
        i = i+1
    outfile.close()
    changeToMatlabDir()
    infile.close()
    return

def changeToGitDir():
    os.chdir('../../../../../../')
    os.chdir('github/rankings/')
    return

def changeToMatlabDir():
    os.chdir('../../')
    os.chdir('Google Drive (jackson.norris@centre.edu)/Summer 2019 Research/MATLAB/Football/2019/ratings')  
    return

def main():
    os.chdir('../..')  
    os.chdir('MATLAB/Football/2019/ratings')
    totalFunction()
    singleFunction('a1.csv','class1.csv')
    singleFunction('a2.csv','class2.csv')
    singleFunction('a3.csv','class3.csv')
    singleFunction('a4.csv','class4.csv')
    singleFunction('a5.csv','class5.csv')
    singleFunction('a6.csv','class6.csv')
    print("well!")
main()


    
