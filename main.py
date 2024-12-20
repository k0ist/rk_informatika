a = '101101'
b = '110011'

a = int(a, 2)
b = int(b, 2)

andr = a & b
sumr = a + b

andres = bin(andr)[2:]
sumres = bin(sumr)[2:]

print("Результат побитовой операции AND:", andres)
print("Сумма чисел:", sumres)