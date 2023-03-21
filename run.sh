cd /home/os2023/os23s67/NachOS-4.0_MP2/code/build.linux
make clean
rm ./nachos
make 2> make-stderr.out

RunFile=./nachos

if [ -f "$RunFile" ]; then

    cd /home/os2023/os23s67/NachOS-4.0_MP2/code/test
    ../build.linux/nachos -e consoleIO_test1 -e consoleIO_test2 2> run-stderr.out
    # ../build.linux/nachos -e consoleIO_test1 2> run-stderr.out


    echo "================================="
    echo "=        Print run stderr       ="
    echo "================================="

    cat run-stderr.out
else

    echo "================================="
    echo "=       Print make stderr       ="
    echo "================================="

    cat make-stderr.out

fi








