import pandas as pd
import matplotlib.pyplot as plt

data = pd.read_excel(r'C:\Users\ihear\Documents\Reddit Data Visualizations\George Washington\Yearly_Aggregated_Orders.xlsx')
data_top = list(data.columns)

purchases_aggregate = data[['Year', '"Textile" Exp', '"Yardg" Exp', '"Grocery Exp']]
print(purchases_aggregate)

graph = purchases_aggregate.plot.area(x = "Year")
plt.show()
