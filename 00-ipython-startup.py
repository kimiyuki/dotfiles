get_ipython().run_line_magic('load_ext', 'autoreload')
get_ipython().run_line_magic('autoreload', '2')
get_ipython().run_line_magic('xmode', 'Plain')
print('autoreload loaded from startup ~/.ipython/...')
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from pandas_datareader import data
pd.set_option("display.max_rows", 6)
import seaborn as sns
iris = sns.load_dataset("iris")
mpg = sns.load_dataset("mpg")
flights = sns.load_dataset("flights")
diamonds = sns.load_dataset("diamonds")
titanic = sns.load_dataset("titanic")
planets = sns.load_dataset("planets")
print('plt, np, pd, sns are loaded')
import requests
from bs4 import BeautifulSoup


