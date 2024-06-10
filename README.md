## Fork of moduledetection-evaluation to analyze a subset of E. Coli Data

# Directory structure 
├── data  
│   ├── Model_evaluations  
│   ├── Model_predictions  
│   ├── RNAseq  
│   └── Regulatory  
├── docs  
├── module_evaluation  
│   └── downloads.py  
└── notebooks  

```
install cython modules with: python setup.py build_ext --inplace
```

RNAseq Expression Data: precise2k (log transformed normalized to M9 reference conditions)
Regulatory data used for evaluation: regulondb (interactions of TF-genes)
