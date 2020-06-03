import matplotlib.pyplot as plt
x = [200,\
210,\
220,\
230,\
240,\
250,\
260,\
270,\
280,\
290,\
300,\
310,\
320,\
]
y = [2500,\
2700,\
2800,\
2900,\
3000,\
3200,\
3300,\
3400,\
3500,\
3700,\
3800,\
3900,\
4000,\
]
plt.plot(x, y)
plt.xlabel('number of kids')
plt.ylabel('cost')
plt.title('cost=f(number of kids)')
plt.show()
