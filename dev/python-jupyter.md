

# Setup

python -m pip install --upgrade pip
python -m pip install jupyter
jupyter notebook



Install Python 3.7.x
Set “Python37” path and “Python37/Scripts” path to environment variable
pip install virtualenv
python -m pip install -upgrade pip
virtualenv opencv --app-data ./pypa/virtualenv
activate.bat
pip install numpy
pip install opencv-python
pip install matplotlib
pip install pandas
pip install pysqlite3

python -m pip install jupyter
jupyter notebook

localhost:8888/tree and create your notebook there.


pip install jupyterlab
jupyter lab
http(s)://<server:port>/<lab-location>/lab


pip install voila
git clone https://github.com/voila-dashboards/voila
cd voila
voila notebooks/bqplot.ipynb

cd notebooks/
voila
see https://github.com/voila-dashboards/voila/tree/master/notebooks



pip install pytesseract
pip install langdetect
pip install requests tqdm



!run command like `pip install pandas`


# Play with Pandas
```
import pandas as pd

data = {
    'apples': [3, 2, 0, 1], 
    'oranges': [0, 3, 7, 2]
}
purchases = pd.DataFrame(data)
purchases
```

```
purchases = pd.DataFrame(data, index=['June', 'Robert', 'Lily', 'David'])
purchases
purchases.loc['June']
```


```purchases.csv
,apples,oranges
June,3,0
Robert,2,3
Lily,0,7
David,1,2
```
```
df = pd.read_csv('data/purchases.csv')
df
```
```
df = pd.read_csv('purchases.csv', index_col=0)
df
```


```
import sqlite3
con = sqlite3.connect('data/fruit_stall.sqlite3')

df = pd.read_sql_query('SELECT * FROM purchases', con)
df = df.set_index('index') # index is the column name
df
```

```
df.to_csv('new_purchases.csv')
df.to_json('new_purchases.json')
df.to_sql('new_purchases', con)
```


```IMDB-Movie-Data.csv
Title,Rank,Genre,Description,Director,Actors,Year,Runtime (Minutes),Rating,Votes,Revenue (Millions),Metascore
Guardians of the Galaxy,1,Action,Adventure,Sci-Fi,A group of intergalactic criminals are forced ...,James Gunn,Chris Pratt, Vin Diesel, Bradley Cooper, Zoe S...,2014,121,8.1,757074,333.13,76.0
Prometheus,2,Adventure,Mystery,Sci-Fi,Following clues to the origin of mankind, a te...,Ridley Scott,Noomi Rapace, Logan Marshall-Green, Michael Fa...,2012,124,7.0,485820,126.46,65.0
Split,3,Horror,Thriller,Three girls are kidnapped by a man with a diag...,M. Night Shyamalan,James McAvoy, Anya Taylor-Joy, Haley Lu Richar...,2016,117,7.3,157606,138.12,62.0
Sing,4,Animation,Comedy,Family,In a city of humanoid animals, a hustling thea...,Christophe Lourdelet,Matthew McConaughey,Reese Witherspoon, Seth Ma...,2016,108,7.2,60545,270.32,59.0
Suicide Squad,5,Action,Adventure,Fantasy,A secret government agency recruits some of th...,David Ayer,Will Smith, Jared Leto, Margot Robbie, Viola D...,2016,123,6.2,393727,325.02,40.0
Search Party,999,Adventure,Comedy,A pair of friends embark on a mission to reuni...,Scot Armstrong,Adam Pally, T.J. Miller, Thomas Middleditch,Sh...,2014,93,5.6,4881,NaN,22.0
Nine Lives,1000,Comedy,Family,Fantasy,A stuffy businessman finds himself trapped ins...,Barry Sonnenfeld,Kevin Spacey, Jennifer Garner, Robbie Amell,Ch...,2016,87,5.3,12435,19.64,11.0
Prometheus,2,Adventure,Mystery,Sci-Fi,Following clues to the origin of mankind, a te...,Ridley Scott,Noomi Rapace, Logan Marshall-Green, Michael Fa...,2012,124,7.0,485820,126.46,65.0
Interstellar,37,Adventure,Drama,Sci-Fi,A team of explorers travel through a wormhole ...,Christopher Nolan,Matthew McConaughey, Anne Hathaway, Jessica Ch...,2014,169,8.6,1047747,187.99,74.0
The Dark Knight,55,Action,Crime,Drama,When the menace known as the Joker wreaks havo...,Christopher Nolan,Christian Bale, Heath Ledger, Aaron Eckhart,Mi...,2008,152,9.0,1791916,533.32,82.0
The Prestige,65,Drama,Mystery,Sci-Fi,Two stage magicians engage in competitive one-...,Christopher Nolan,Christian Bale, Hugh Jackman, Scarlett Johanss...,2006,130,8.5,913152,53.08,66.0
Inception,81,Action,Adventure,Sci-Fi,A thief, who steals corporate secrets through ...,Christopher Nolan,Leonardo DiCaprio, Joseph Gordon-Levitt, Ellen...,2010,148,8.8,1583625,292.57,74.0
3 Idiots,431,Comedy,Drama,Two friends are searching for their long lost ...,Rajkumar Hirani,Aamir Khan, Madhavan, Mona Singh, Sharman Joshi,2009,170,8.4,238789,6.52,67.0
The Lives of Others,477,Drama,Thriller,In 1984 East Berlin, an agent of the secret po...,Florian Henckel von Donnersmarck,Ulrich Mühe, Martina Gedeck,Sebastian Koch, Ul...,2006,137,8.5,278103,11.28,89.0
Incendies,714,Drama,Mystery,War,Twins journey to the Middle East to discover t...,Denis Villeneuve,Lubna Azabal, Mélissa Désormeaux-Poulin, Maxim...,2010,131,8.2,92863,6.86,80.0
Taare Zameen Par,992,Drama,Family,Music,An eight-year-old boy is thought to be a lazy ...,Aamir Khan,Darsheel Safary, Aamir Khan, Tanay Chheda, Sac...,2007,165,8.5,102697,1.20,42.0
Guardians of the Galaxy,1,Action,Adventure,Sci-Fi,A group of intergalactic criminals are forced ...,James Gunn,Chris Pratt, Vin Diesel, Bradley Cooper, Zoe S...,2014,121,8.1,757074,333.13,76.0,good
Prometheus,2,Adventure,Mystery,Sci-Fi,Following clues to the origin of mankind, a te...,Ridley Scott,Noomi Rapace, Logan Marshall-Green, Michael Fa...,2012,124,7.0,485820,126.46,65.0,bad
Guardians of the Galaxy,1,Action,Adventure,Sci-Fi,A group of intergalactic criminals are forced ...,James Gunn,Chris Pratt, Vin Diesel, Bradley Cooper, Zoe S...,2014,121,8.1,757074,333.13,76.0,good
Prometheus,2,Adventure,Mystery,Sci-Fi,Following clues to the origin of mankind, a te...,Ridley Scott,Noomi Rapace, Logan Marshall-Green, Michael Fa...,2012,124,7.0,485820,126.46,65.0,bad
```
```
movies_df = pd.read_csv("IMDB-Movie-Data.csv", index_col="Title")

movies_df.head()
movies_df.tail(10)
```

```
movies_df.info()
```
```
movies_df.shape
```

```
temp_df = movies_df.append(movies_df)
temp_df.shape
```
```
temp_df = temp_df.drop_duplicates()
temp_df.drop_duplicates(inplace=True)
temp_df.shape
```

```
temp_df.drop_duplicates(inplace=True, keep=False)
temp_df.shape
```

```
movies_df.columns
```

```
movies_df.rename(columns={'Runtime (Minutes)': 'Runtime', 'Revenue (Millions)': 'Revenue_millions'}, inplace=True)
movies_df.columns
```

```
movies_df.columns = [col.lower() for col in movies_df]
```


```
movies_df.isnull()
```
```
movies_df.isnull().sum()
```
```
new_nonull_movies_df = movies_df.dropna()
new_nonull_movies_df
```
```
new_nonullcolumns_movies_df = movies_df.dropna(axis=1)
new_nonullcolumns_movies_df
```

```
revenue = movies_df['revenue_millions']
revenue.head()
```
```
revenue_mean = revenue.mean()
revenue_mean
```
```
revenue.fillna(revenue_mean, inplace=True)     ## Notice that by using inplace=True we have actually affected the original movies_df!
movies_df.isnull().sum()
```

```
movies_df.describe()
```
```
movies_df['genre'].describe()
```
```
movies_df['genre'].value_counts().head(10)
```

```
movies_df.corr()
```


```
genre_col = movies_df['genre']
type(genre_col)   # => pandas.core.series.Series
```
```
genre_col = movies_df[['genre']]
type(genre_col)   # => pandas.core.frame.DataFrame
```
```
subset = movies_df[['genre', 'rating']]
subset.head()
```

```
prom = movies_df.loc['Prometheus']
prom
```
```
prom = movies_df.iloc[1]
prom
```
```
movie_subset_by_rows_title = movies_df.loc['Prometheus':'Sing']
movie_subset_by_rows_title
```
```
movie_subset_by_rows_index = movies_df.iloc[1:4]
movie_subset_by_rows_index		## Similar as slicing with python's lists, the movie at index 4 is not included.
```

```
condition = (movies_df['director'] == 'Ridley Scott')
condition.head()
```
```
#conditional_selections = movies_df[condition]
conditional_selections = movies_df[movies_df['director'] == 'Ridley Scott']
conditional_selections
```
```
movies_df[movies_df['rating'] >= 8.6].head(3)
movies_df[(movies_df[director] == 'Christopher Nolan') | (movies_df[director] == 'Ridley Scott')].head()
movies_df[movies_df['director'].isin(['Christopher Nolan', 'Ridley Scott'])].head()
movies_df[
	((movies_df['year'] >= 2005) & (movies_df['year'] <= 2010))
	& (movies_df['rating'] > 8.0)
	& (movies_df['revenue_millions'] < movies_df['revenue_millions'].quantile(0.25))
]
# TIPS: Compare the result with .describe()'s percentile result
```


```
def rating_function(x):
	if x >= 8.0:
		return 'good'
	else:
		return 'bad'

movies_df['rating_category'] = movies_df['rating'].apply(rating_function)
movies_df.head(2)
```
```
movies_df['rating_category'] = movies_df['rating'].apply(lambda x: 'good' if x >= 8.0 else 'bad')
movies_df.head(2)
```


```
import matplotlib.pyplot as plt
plt.rcParams.update({'font.size': 20, 'figure.figsize': (10, 8)})

movies_df.plot(kind='scatter', x='rating', y='revenue_millions', title='Revenue (millions) vs Rating');
# NOTE!!! Need to put semicolon at the end to hide the object output
```
```
movies_df['rating'].plot(kind='hist', title='Rating');
```
```
movies_df['rating'].describe()
```
```
movies_df['rating'].plot(kind='box');
# TIPS: Compare the result with movies_df['rating'].describe()
```
```
movies_df.boxplot(colum='revenue_millions', by='rating_category')
```




```
pd.DataFrame({'Yes': [50, 21], 'No': [131, 2]})
```
```
pd.DataFrame({'Bob': ['I liked it.', 'It was awful.'], 'Sue': ['Pretty good.', 'Bland.']})
```
```
pd.DataFrame({'Bob': ['I liked it.', 'It was awful.'], 'Sue': ['Pretty good.', 'Bland.']}, index=['Product A', 'Product B'])
```
```
pd.Series([1, 2, 3, 4, 5])
```
```
pd.Series([30, 35, 40], index=['2015 Sales', '2016 Sales', '2017 Sales'], name='Product A')
```
```winemag-data-130k-v2.csv
,country,description,designation,points,price,province,region_1,region_2,taster_name,taster_twitter_handle,title,variety,winery
0,Italy,Aromas include tropical fruit, broom, brimston...,Vulkà Bianco,87,NaN,Sicily & Sardinia,Etna,NaN,Kerin O’Keefe,@kerinokeefe,Nicosia 2013 Vulkà Bianco (Etna),White Blend,Nicosia
1,Portugal,This is ripe and fruity, a wine that is smooth...,Avidagos,87,15.0,Douro,NaN,NaN,Roger Voss,@vossroger,Quinta dos Avidagos 2011 Avidagos Red (Douro),Portuguese Red,Quinta dos Avidagos
2,US,Tart and snappy, the flavors of lime flesh and...,NaN,87,14.0,Oregon,Willamette Valley,Willamette Valley,Paul Gregutt,@paulgwine,Rainstorm 2013 Pinot Gris (Willamette Valley),Pinot Gris,Rainstorm
3,US,Pineapple rind, lemon pith and orange blossom ...,Reserve Late Harvest,87,13.0,Michigan,Lake Michigan Shore,NaN,Alexander Peartree,NaN,St. Julian 2013 Reserve Late Harvest Riesling ...,Riesling,St. Julian
4,US,Much like the regular bottling from 2012, this...,Vintner's Reserve Wild Child Block,87,65.0,Oregon,Willamette Valley,Willamette Valley,Paul Gregutt,@paulgwine,Sweet Cheeks 2012 Vintner's Reserve Wild Child...,Pinot Noir,Sweet Cheeks
```
```
wine_reviews = pd.read_csv('../input/wine-reviews/winemag-data-130k-v2.csv')
wine_reviews.shape
```
```
wine_reviews.head()
```
```
wine_reviews = pd.read_csv('../input/wine-reviews/winemag-data-130k-v2.csv', index_col=0)
```

```
import numpy as np
import pandas as pd

data = np.array([['', 'Col1', 'Col2'], 
				['Row1', 1, 2],
				['Row2', 3, 4]])
print(pd.DataFrame(data=data[1:,1:], index=[1:,0], columns=data[0,1:]))
```
```
my_2darray = np.array([[1, 2, 3], [4, 5, 6]])
my_2darray
```
```
my_dict = {1: ['1', '3'], 2: ['1', '2'], 3: ['2', '4']}
my_dict
```
```
my_df = pd.DataFrame(data=[4, 5, 6, 7], index=range(0,4), columns=['A'])
my_df
```
```
df = pd.DataFrame(np.array([[1, 2, 3], [4, 5, 6]]))
```
```
df[0].count()
```
```
list(my_dataframe.columns.values)
```
```DataFrame
   A  B  C
0  1  2  3
1  4  5  6
2  7  8  9

data = np.array([['', 'A', 'B', 'C'], 
				[0, 1, 2, 3],
				[1, 4, 5, 6],
				[2, 7, 8, 9]])
df = pd.DataFrame(data=data[1:,1:], index=[1:,0], columns=data[0,1:])
print(df.iloc[0][0])
print(df.loc[0]['A'])
print(df.at[0,'A'])
print(df.iat[0,0])

print(df.iloc[_]) # -> select row 0
print(df.loc[:, '_']) # -> select column A

df = pd.DataFrame(data=np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]]), index= [2, 'A', 4], columns=[48, 49, 50])

# Pass `2` to `loc`
print(df.loc[_])

# Pass `2` to `iloc`
print(df.iloc[_])

# Pass `2` to `ix`
print(df.ix[_])
```

```
df = pd._________(data=np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]]), index= [2.5, 12.6, 4.8], columns=[48, 49, 50])

# There's no index labeled `2`, so you will change the index at position `2`
df.ix[2] = [60, 50, 40]
print(df)

# This will make an index labeled `2` and add the new values
df.loc[2] = [11, 12, 13]
print(df)
```

```
df = pd._________(data=np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]]), columns=['A', 'B', 'C'])

# Use `.index`
df['D'] = df.index

# Print `df`
print(__)
```
```
# Study the DataFrame `df`
print(__)

# Append a column to `df`
df.loc[:, 4] = pd.Series(['5', '6'], index=df.index)

# Print out `df` again to see the changes
_____(__)
```

```
# Check out the weird index of your dataframe
print(df)

# Use `reset_index()` to reset the values. 
df_reset = df.__________(level=0, drop=True)

# Print `df_reset`
print(df_reset)
```
```
df = pd.DataFrame(data=np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9], [40, 50, 60], [23, 35, 37]]), 
                  index= [2.5, 12.6, 4.8, 4.8, 2.5], 
                  columns=[48, 49, 50])
                  
df.___________.drop_duplicates(subset='index', keep='last').set_index('index')
```
```
# Check out the DataFrame `df`
print(__)

# Drop the column with label 'A'                  
df.____('A', axis=1, inplace=True)

# Drop the column at position 1
df.____(df.columns[[1]], axis=1)
```
```
# Check out your DataFrame `df`
print(__)

# Drop the duplicates in `df`
df.________([48], keep='last')
```
```
# Check out the DataFrame `df`
print(__)

# Drop the index at position 1
df.____(df.index[_])
```

```
# Check out your DataFrame `df`
print(__)

# Define the new names of your columns
newcols = {
    'A': 'new_column_1', 
    'B': 'new_column_2', 
    'C': 'new_column_3'
}

# Use `rename()` to rename your columns
df.______(columns=newcols, inplace=True)

# Use `rename()` to your index
df.______(index={1: 'a'})
```

```
# Study the DataFrame `df` first
_____(df)

# Replace the strings by numerical values (0-4)
df._______(['Awful', 'Poor', 'OK', 'Acceptable', 'Perfect'], [0, 1, 2, 3, 4]) 
```
```
# Check out your DataFrame `df`
print(df)

# Replace strings by others with `regex`
df.replace({'\n': '<br>'}, regex=True)


# Check out your DataFrame
_____(df)

# Delete unwanted parts from the strings in the `result` column
df['result'] = df['result'].map(lambda x: x.lstrip('+-').rstrip('aAbBcC'))

# Check out the result again
df


# Inspect your DataFrame `df`
print(__)

# Split out the two values in the third row
# Make it a Series
# Stack the values
ticket_series = df['Ticket'].str.split(' ').apply(pd.Series, 1).stack()

# Get rid of the stack:
# Drop the level to line up with the DataFrame
ticket_series.index = ticket_series.index.droplevel(-1)

# Make your `ticket_series` a dataframe 
ticketdf = pd.________(ticket_series)

# Delete the `Ticket` column from your DataFrame
del df['Ticket']

# Join the `ticketdf` DataFrame to `df`
df.____(ticketdef)

# Check out the new `df`
df


doubler = lambda x: x*2
# Study the `df` DataFrame
_____(__)

# Apply the `doubler` function to the `A` DataFrame column
df['A'].apply(doubler)

df.loc[0].apply(doubler)



def doubler(x):
    if x % 2 == 0:
        return x
    else:
        return x * 2

# Use `applymap()` to apply `doubler()` to your DataFrame
doubled_df = df.applymap(doubler)

# Check the DataFrame
print(doubled_df)


df = pd.DataFrame(np.nan, index=[0,1,2,3], columns=['A'])
print(df)

df = pd.DataFrame(index=range(0,4),columns=['A'], dtype='float')
print(df)


import pandas as pd
pd.read_csv('yourFile', parse_dates=True)
# or this option:
pd.read_csv('yourFile', parse_dates=['columnName'])


import pandas as pd
dateparser = lambda x: pd.datetime.strptime(x, '%Y-%m-%d %H:%M:%S')

# Which makes your read command:
pd.read_csv(infile, parse_dates=['columnName'], date_parser=dateparse)
# Or combine two columns into a single DateTime column
pd.read_csv(infile, parse_dates={'datetime': ['date', 'time']}, date_parser=dateparse)




# Import pandas
import ______ as pd

products = pd.DataFrame({'category': ['Cleaning', 'Cleaning', 'Entertainment', 'Entertainment', 'Tech', 'Tech'],
                        'store': ['Walmart', 'Dia', 'Walmart', 'Fnac', 'Dia','Walmart'],
                        'price':[11.42, 23.50, 19.99, 15.95, 55.75, 111.55],
                        'testscore': [4, 3, 5, 7, 5, 8]})

# Use `pivot()` to pivot the DataFrame
pivot_products = products._____(index='category', columns='store', values='price')

# Check out the result
print(pivot_products)




# Import the Pandas library
import ______ as pd

# Construct the DataFrame
products = pd.DataFrame({'category': ['Cleaning', 'Cleaning', 'Entertainment', 'Entertainment', 'Tech', 'Tech'],
                        'store': ['Walmart', 'Dia', 'Walmart', 'Fnac', 'Dia','Walmart'],
                        'price':[11.42, 23.50, 19.99, 15.95, 55.75, 111.55],
                        'testscore': [4, 3, 5, 7, 5, 8]})

# Use `pivot()` to pivot your DataFrame
pivot_products = products._____(index='category', columns='store')

# Check out the results
print(pivot_products)





# Import the Pandas library
import ______ as pd

# Your DataFrame
products = pd.DataFrame({'category': ['Cleaning', 'Cleaning', 'Entertainment', 'Entertainment', 'Tech', 'Tech'],
                        'store': ['Walmart', 'Dia', 'Walmart', 'Fnac', 'Dia','Walmart'],
                        'price':[11.42, 23.50, 19.99, 15.95, 19.99, 111.55],
                        'testscore': [4, 3, 5, 7, 5, 8]})

# Pivot your `products` DataFrame with `pivot_table()`
pivot_products = products.___________(index='category', columns='store', values='price', aggfunc='mean')

# Check out the results
print(pivot_products)




# The `people` DataFrame
people = pd.DataFrame({'FirstName' : ['John', 'Jane'],
                       'LastName' : ['Doe', 'Austen'],
                       'BloodType' : ['A-', 'B+'],
                       'Weight' : [90, 64]})

# Use `melt()` on the `people` DataFrame
print(pd.____(people, id_vars=['FirstName', 'LastName'], var_name='measurements'))




df = pd.DataFrame(data=np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]]), columns=['A', 'B', 'C'])

for index, row in df.iterrows() :
    print(row['A'], row['B'])




import pandas as pd
df.to_csv('myDataFrame.csv')
df.to_csv('myDataFrame.csv', sep='\t')
df.to_csv('myDataFrame.csv', sep='\t', encoding='utf-8')

writer = pd.ExcelWriter('myDataFrame.xlsx')
df.to_excel(writer, 'DataFrame')
writer.save()
```



```
dict = {"country": ["Brazil", "Russia", "India", "China", "South Africa"],
       "capital": ["Brasilia", "Moscow", "New Dehli", "Beijing", "Pretoria"],
       "area": [8.516, 17.10, 3.286, 9.597, 1.221],
       "population": [200.4, 143.5, 1252, 1357, 52.98] }

import pandas as pd
brics = pd.DataFrame(dict)
print(brics)

brics.index = ["BR", "RU", "IN", "CH", "SA"]
print(brics)


cars = pd.read_csv('cars.csv')
print(cars)

cars = pd.read_csv('cars.csv', index_col = 0)
print(cars['cars_per_cap'])
print(cars[['cars_per_cap']])
print(cars[['cars_per_cap', 'country']])

print(cars[0:4])
print(cars[4:6])
print(cars.iloc[2])
print(cars.loc[['AUS', 'EG']])
```










cd D:\WS\python\opencv\Books
..\Scripts\activate




# Matplotlib
- For categorical variables utilize Bar Charts* and Boxplots.
- For continuous variables utilize Histograms, Scatterplots, Line graphs, and Boxplots.
- Types of Plots: Bar Graph, Histogram, Scatter Plot, Area Plot, Pie Plot

```
from matplotlib import pyplot as plt

plt.plot([1, 2, 3], [4, 5, 1])
plt.show()

x = [5, 2, 7]
y = [2, 16, 4]
plt.plot(x, y)
plt.title('Info')
plt.ylabel('Y axis')
plt.xlabel('X axis')
plt.show()
```

```
from matplotlib import pyplot as plt
from matplotlib import style

style.use('ggplot')
x = [5, 8, 10]
y = [12, 16, 6]
x2 = [6, 9, 11]
y2 = [6, 15, 7]
plt.plot(x, y, 'g', label='line one', linewidth=5)
plt.plot(x2, y2, 'c', label='line two', linewidth=5)
plt.title('Epic Info')
plt.ylabel('Y axis')
plt.xlabel('X axis')
plt.legend()
plt.grid(True, color='k')
plt.show()
```

```
plt.bar([0.25,1.25,2.25,3.25,4.25],[50,40,70,80,20],
label="BMW",width=.5)
plt.bar([.75,1.75,2.75,3.75,4.75],[80,20,20,50,60],
label="Audi", color='r',width=.5)
plt.legend()
plt.xlabel('Days')
plt.ylabel('Distance (kms)')
plt.title('Information')
plt.show()
```

```
import matplotlib.pyplot as plt
population_age = [22,55,62,45,21,22,34,42,42,4,2,102,95,85,55,110,120,70,65,55,111,115,80,75,65,54,44,43,42,48]
bins = [0,10,20,30,40,50,60,70,80,90,100]
plt.hist(population_age, bins, histtype='bar', rwidth=0.8)
plt.xlabel('age groups')
plt.ylabel('Number of people')
plt.title('Histogram')
plt.show()
```

```
x = [1,1.5,2,2.5,3,3.5,3.6]
y = [7.5,8,8.5,9,9.5,10,10.5]
 
x1=[8,8.5,9,9.5,10,10.5,11]
y1=[3,3.5,3.7,4,4.5,5,5.2]
 
plt.scatter(x,y, label='high income low saving',color='r')
plt.scatter(x1,y1,label='low income high savings',color='b')
plt.xlabel('saving*100')
plt.ylabel('income*1000')
plt.title('Scatter Plot')
plt.legend()
plt.show()
```

```
days = [1,2,3,4,5]
  
sleeping =[7,8,6,11,7]
eating = [2,3,4,3,2]
working =[7,8,7,2,2]
playing = [8,5,7,8,13]

plt.plot([],[],color='m', label='Sleeping', linewidth=5)
plt.plot([],[],color='c', label='Eating', linewidth=5)
plt.plot([],[],color='r', label='Working', linewidth=5)
plt.plot([],[],color='k', label='Playing', linewidth=5)

plt.stackplot(days, sleeping,eating,working,playing, colors=['m','c','r','k'])

plt.xlabel('x')
plt.ylabel('y')
plt.title('Stack Plot')
plt.legend()
plt.show()
```

```
days = [1,2,3,4,5]
 
sleeping =[7,8,6,11,7]
eating = [2,3,4,3,2]
working =[7,8,7,2,2]
playing = [8,5,7,8,13]
slices = [7,2,2,13]
activities = ['sleeping','eating','working','playing']
cols = ['c','m','r','b']
 
plt.pie(slices,
  labels=activities,
  colors=cols,
  startangle=90,
  shadow= True,
  explode=(0,0.1,0,0),
  autopct='%1.1f%%')
 
plt.title('Pie Plot')
plt.show()
```


```
import numpy as np
import matplotlib.pyplot as plt
 
def f(t):
    return np.exp(-t) * np.cos(2*np.pi*t)
t1 = np.arange(0.0, 5.0, 0.1)
t2 = np.arange(0.0, 5.0, 0.02)
plt.subplot(221)
plt.plot(t1, f(t1), 'bo', t2, f(t2))
plt.subplot(222)
plt.plot(t2, np.cos(2*np.pi*t2))
plt.show()
```




TODO... try more


TODO
https://www.learndatasci.com/tutorials/data-science-statistics-using-python/
https://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.plot.html
https://pandas.pydata.org/pandas-docs/stable/tutorials.html
https://www.kaggle.com/kernels
https://www.learndatasci.com/out/coursera-Applied-Data-Science-with-Python/
https://www.kaggle.com/residentmario/creating-reading-and-writing
https://www.datacamp.com/community/tutorials/matplotlib-tutorial-python
