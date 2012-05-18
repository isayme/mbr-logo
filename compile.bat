echo off
call C:\Progra~1\nasm\nasm.exe boot.asm -o boot.bin
call tools\dd count=1 if=boot.bin of=a.img
call tools\frdwr image.bin a.img 15
pause