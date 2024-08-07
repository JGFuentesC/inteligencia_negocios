import pandas as pd 
import os 
import json
from datetime import date 

class Loan:
    file = None 
    data = None 
    id = None 
    columns = ['id', 'loan_amnt', 'term', 'sub_grade', 'emp_title', 'home_ownership',
       'annual_inc', 'issue_d', 'loan_status', 'purpose', 'addr_state', 'dti',
       'inq_last_6mths', 'total_acc', 'num_accts_ever_120_pd']
    renColumns = ['loanID', 'loanAmount', 'loanTerm', 'subGrade', 'empTitle', 'homeOwnership',
         'annualIncome', 'issueDate', 'loanStatus', 'purpose', 'addressState', 'debtToIncome',
            'inquiriesLast6Months', 'totalAccounts', 'accountsEver120']
    dtypes = [str,'float64',str,str,str,str,'float64',date,str,str,str,'float64','int64','int64','int64']
    
    def __changeDType(self,column_name,dtype):
         if dtype is str:
               return self.data[column_name].astype(str).map(str.upper)
         elif dtype == 'float64':
               return pd.to_numeric(self.data[column_name],errors='coerce').astype(dtype)
         elif dtype == 'int64':
               return pd.to_numeric(self.data[column_name],errors='coerce').fillna(0).astype(dtype)
         elif dtype is date:
               return pd.to_datetime(self.data[column_name],errors='coerce').dt.date
         
    def __cleanStrings(self,column_name):
         if column_name == 'term':
               self.data[column_name] = self.data[column_name].map(lambda x:x[:2])
         elif column_name == 'loan_status':
              self.data[column_name] = self.data[column_name].map(lambda x:"_".join(x.split(' ')))

    def __cleanIssueDate(self):
         self.data['issue_d'] = pd.to_datetime(self.data['issue_d'],format='%b-%Y',errors='coerce').dt.date

    def toParquet(self,path='.'):
        self.data.to_parquet(os.path.join(path,f'{self.id}.parquet'),index=False)

    def __init__(self, file):
        self.file = file
        self.id = file.split('/')[-1].split('.')[0]
        self.data = pd.Series(json.load(open(file,'r'))).to_frame().T
        self.__cleanStrings('term')
        self.__cleanStrings('loan_status')
        self.__cleanIssueDate()
        for col,dtype in zip(self.columns,self.dtypes):
            self.data[col] = self.__changeDType(col,dtype)
        self.data.rename(columns=dict(zip(self.columns,self.renColumns)),inplace=True)

        
        