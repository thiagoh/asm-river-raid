# asm-river-raid
Simple River Raid game made in assembly

# Build in Ubuntu

The steps were taken from (http://lifepluslinux.blogspot.com.br/2013/03/installing-turbo-assembler-tasm-turbo.html)

## Installing Turbo Assembler (TASM), Turbo Debugger (TD) on Ubuntu

### Step 1

First we will install an windows emulator called dosbox.
```
sudo apt-get install dosbox
```

### Step2

Download the packages for Turbo Assembler(tasm) Turbo Debugger(td). Create a directory for tasm in your home directory and extract files into that directory.If you are unable to extract type this in your terminal and try again
```
sudo apt-get install unrar
```

### Step3
Open dosbox( generally found in games sublist ). Now you have to mount the virtual c drive.
```
mount c /home/<username>
```

### Step4

Now go to your TASM directory and put the files inside it


### Step5
```
# compile
> tasm.exe rr.asm

# link 
> tlink.exe rr.obj


# execute
> rr.exe
```
