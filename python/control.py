import os
os.system("python binary.py")
os.system("iverilog control1.v ;./a.out ;gtkwave dump.vcd")