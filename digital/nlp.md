
data.world https://data.world/promptcloud/fashion-products-on-amazon-com


```py
import pandas as pd
import nltk
from bs4 import BeautifulSoap
import string
from nltk.corpus import stopwords
from nltk.tokenize import RegexpTokenizer
from nltk.stem import WordNetLemmatizer
from nltk.stem.porter import PorterStemmer
```

```
nltk.download()

df = pd.read_csv('amazon_co-ecommerce_sample.csv')
df.shape

```






