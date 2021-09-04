import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import FormatStrFormatter, StrMethodFormatter

data = pd.read_excel(r'C:\Users\ihear\Documents\Reddit Data Visualizations\George Washington\Yearly_Aggregated_Orders.xlsx')
data_top = list(data.columns)

purchases_aggregate = data[['Year', '"Textile" Exp', '"Yardg" Exp', '"Grocery Exp']]
# print(purchases_aggregate)

full_years = pd.DataFrame({'Year': range(1754, 1772, 1)})
# print(full_years)

full_years_aggreggate = pd.concat([full_years.set_index('Year'), purchases_aggregate.set_index('Year')], axis = 1).reset_index()
full_years_aggreggate = full_years_aggreggate.rename(
    columns={'"Textile" Exp': "Textiles", '"Yardg" Exp': "Yardage", '"Grocery Exp':"Groceries"})
# print(full_years_aggreggate)

graph = full_years_aggreggate.plot.line(x = "Year")
full_years_aggreggate.plot.scatter(x = "Year", y = 'Textiles', ax = graph)
full_years_aggreggate.plot.scatter(x = "Year", y = 'Yardage', c = "C1", ax = graph)
full_years_aggreggate.plot.scatter(x = "Year", y = 'Groceries', c = "C2", ax = graph)
plt.xticks(np.arange(min(full_years_aggreggate['Year']), max(full_years_aggreggate['Year'])+1, 3.0))
plt.yticks(np.arange(0, 60000, 5000))
graph.yaxis.set_major_formatter(StrMethodFormatter('{x:,.0f}'))
graph.set_ylabel("Pence")
plt.show()
