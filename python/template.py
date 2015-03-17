import sys,os

GVIM = r"C:\SHARE_WITH_LAPTOP\Vim\vim74\gvim.exe"
OUTPUT = r"C:\SHARE_WITH_LAPTOP\Vim\python\tempout.txt"
INPUT = r"C:\SHARE_WITH_LAPTOP\Vim\python\tempin.txt"

def main():
    module = sys.argv[1]
    fin = open(module, "r")
    fout = open(OUTPUT, "w")
    
    fout.close()
    fin.close()
    os.system("%s %s" % (GVIM,OUTPUT))

if (__name__ == "__main__"):
    main()
