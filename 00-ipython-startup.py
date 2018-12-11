try:
    get_ipython().run_line_magic('load_ext', 'autoreload')
    get_ipython().run_line_magic('autoreload', '2')
    get_ipython().run_line_magic('load_ext', 'memory_profiler')
    get_ipython().run_line_magic('xmode', 'Plain')
    print('autoreload loaded from startup ~/.ipython/...')
except NameError:
    print('no ipython')

import re
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from pandas_datareader import data
pd.set_option("display.max_rows", 6)
pd.set_option("display.max_colwidth", 70)

## itertools
from itertools import *
def pair_wise(iterable, tail=True):
    a,b = tee(iterable)
    next(b, None)
    return zip_longest(a,b) if tail else zip(a,b)

def show_df_blk(df, nrow=10, ncol=4):
    """show dataframe with blocks. i: num rows, j: num cols"""
    with pd.option_context("display.max_rows", nrow):
        for g in pair_wise(range(0, df.shape[1], ncol)):
            #print(g)
            print(df.iloc[:nrow, slice(*g)], "\n")

def grouper(iterable, n, fillvalue=None):
   "Collect data into fixed-length chunks or blocks"
   # grouper('ABCDEFG', 3, 'x') --> ABC DEF Gxx"
   args = [iter(iterable)] * n
   return zip_longest(*args, fillvalue=fillvalue)

def show_more(df, n=10000):
    """ print more because I restrict default print in pandas of display.max_rows"""
    with pd.option_context("display.max_rows", n):
        #display(df)
        print(df)
    #return df; if i can preventn to output to console, comment-out it
    #get_ipython().run_line_magic('page') 

from vega_datasets import data
iris = data('iris')
cars = data('cars')
movies = data('movies')
sp500 = data('sp500')
stock = data('stocks')

import seaborn as sns
#sns.set(style='darkgrid', font='TakaoGothic')
flights = sns.load_dataset("flights")
diamonds = sns.load_dataset("diamonds")
titanic = sns.load_dataset("titanic")
planets = sns.load_dataset("planets")
print('plt, np, pd, sns, altair are loaded')
import requests
from bs4 import BeautifulSoup


