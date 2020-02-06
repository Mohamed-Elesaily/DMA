

  
fileopen = open("machine.txt",'w+')
fileopen.write("")
fileopen = open("data.txt",'r')
pc =fileopen.readlines()    
print(pc[0])  
zeros = "00000000"
fileopen = open("machine.txt",'a+')
# def binary(b):
#     b[1]=zeros[:8-len(str(bin(int(b[1])))[2:])] + str(bin(int(b[1])))[2:]
#     b[2]=zeros[:8-len(str(bin(int(b[2])))[2:])] + str(bin(int(b[2])))[2:]
#     b[3]=zeros[:8-len(str(bin(int(b[3])))[2:])] + str(bin(int(b[3])))[2:]
#     a = b[3]+b[2]+b[1]+b[0]
#     fileopen.write(a)
#     fileopen.write('\n')
#     print(len(a))
# for i in pc:
#     i= i[:len(i)-1].split(" ")
#     print(i)
#     binary(i)

pc = pc[0].split(" ")

b1 = zeros[:8-len(str(bin(int(pc[2])))[2:])] + str(bin(int(pc[2])))[2:]
b3 = zeros[:8-len(str(bin(int(pc[3])))[2:])] + str(bin(int(pc[3])))[2:]
b=pc[0]+b1+zeros[:8-len(str(bin(int(pc[1])))[2:])] + str(bin(int(pc[1])))[2:]+b3
fileopen.write(b)
print(b)

