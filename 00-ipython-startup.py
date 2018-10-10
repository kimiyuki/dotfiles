get_ipython().run_line_magic('load_ext', 'autoreload')
get_ipython().run_line_magic('autoreload', '2')
get_ipython().run_line_magic('xmode', 'Plain')
print('autoreload loaded from startup ~/.ipython/...')
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns
print('plt, np, pd, sns are loaded')


