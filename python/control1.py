import os
os.system("python binary.py")
os.system("iverilog control.v ;./a.out ;gtkwave dump.vcd")