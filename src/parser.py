import pandas as pd
import math


data1 = pd.read_excel("../dataset2.xlsx", encoding='ascii', errors='ignore')

data2 = pd.read_excel("../dataset.xlsx", sheet_name=None, encoding='ascii', errors='ignore')

rows = 0
total_dist = 0
entries = 0
items = list(data2.items())

for (a,b) in items:
	for x in range(0, len(b) - 1):
		carreira = str(a)
		gid1 = str(int(b.iloc[x,0]))
		gid2 = str(int(b.iloc[x+1,0]))
		dx = float(b.iloc[x+1,1]) - float(b.iloc[x,1])
		dy = float(b.iloc[x+1,2]) - float(b.iloc[x,2])
		dist = math.sqrt(dx**2 + dy**2)
		if not math.isnan(dist):
			total_dist = total_dist + dist
			entries = entries + 1
			print('?- assert( aresta(' + carreira + ', ' + gid1 + ', ' + gid2 + ', '  + str(dist) + ') ).')
			print('?- assert( aresta(' + carreira + ', ' + gid2 + ', ' + gid1 + ', '  + str(dist) + ') ).')

data1['Freguesia'] = data1['Freguesia'].fillna("Quebrada")

for x in range(0, len(data1)):
	gid = str(int(data1.iloc[x,0]))
	latitude = str(float(data1.iloc[x,1]))
	longitude = str(float(data1.iloc[x,2]))
	conserv = str(data1.iloc[x,3])
	abrigo = str(data1.iloc[x,4])
	publi = str(data1.iloc[x,5])
	operador = str(data1.iloc[x,6])
	carreira = str(data1.iloc[x,7])
	coderua = str(int(data1.iloc[x,8]))
	rua = data1.iloc[x,9]
	freg = data1.iloc[x,10]
	print('?- assert( nodo(' + gid + ', ' + latitude + ', ' + longitude + ', \'' + conserv + '\', \'' + abrigo + '\', \'' + publi + '\', \'' + operador + '\', [' + carreira + '], ' + coderua + ', \'' +  rua.encode('ascii','ignore').replace(',','-') + '\', \'' + freg.encode('ascii','ignore').replace(',','-') + '\') ).')

#print(data1.iloc[0,1])
#print(str(total_dist / entries))
