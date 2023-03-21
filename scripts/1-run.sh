
#!/bin/sh

# Run script for hw1 tests.

# e.g.
#         sh run.sh -build tb -tb custom        
#         sh run.sh -build tb -tb default
#         sh run.sh -build nachos -tb custom
#         sh run.sh -build all -tb default

tbOption=""
buildOption=""

while test $# -gt 0
do
    case "$1" in
        -tb) 
            tbOption=${2}
            ;;
        -build) 
            buildOption=${2}
            ;;            
        -*) 
            echo "bad option $1"
            ;;
    esac
    shift
done




echo ""
echo ""

if [ ${buildOption} = "nachos" ] || [ ${buildOption} = "all" ];
then

    echo "================================="
    echo "=         Build NachOS          ="
    echo "================================="

    cd ~/NachOS-4.0_MP1/code/build.linux
    make clean
    make

    echo "================================="
    echo "=     Finished build NachOS     ="
    echo "================================="

fi



if [ ${buildOption} = "tb" ] || [ ${buildOption} = "all" ];
then
    
    
    echo "================================="
    echo "=      Build test program       ="
    echo "================================="
    
    cd ~/NachOS-4.0_MP1/code/test
    python3 ./tb-generator/tb-generator.py 2>tb-generator-stderr.out
    make clean
    make 2>make-stderr.out

    echo "================================="
    echo "=  Finished build test program  ="
    echo "================================="
fi

echo "================================="
echo "=       Run test program        ="
echo "================================="


if [ ${tbOption} = "default" ];
then
    rm file*.test

    echo "[stderr from fileIO_test1]" 1>nachOS-prog-stderr.out
    ../build.linux/nachos -e fileIO_test1 2>>nachOS-prog-stderr.out

    echo "[stderr from fileIO_test2]" 1>>nachOS-prog-stderr.out
    ../build.linux/nachos -e fileIO_test2 2>>nachOS-prog-stderr.out

elif [ ${tbOption} = "custom" ];
then
    rm file*.txt
    ../build.linux/nachos -e tb 2>nachOS-prog-stderr.out
fi


echo "================================="
echo "=       Print stderr out        ="
echo "================================="

echo "[tb-generator stderr out]:"

echo ""
cat tb-generator-stderr.out
echo ""

echo "[make stderr out]:"

echo ""
cat make-stderr.out
echo ""

echo "[nachOS-prog stderr out]:"

echo ""
cat nachOS-prog-stderr.out
echo ""


echo "================================="
echo "=             Done              ="
echo "================================="
echo ""
echo ""