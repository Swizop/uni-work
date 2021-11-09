Create new processes in C




1. Creat, i un proces nou folosind fork(2) s, i afis,at, i fis, ierele din directorul
curent cu ajutorul execve(2). Din procesul init, ial afis,at, i pid-ul propriu
s, i pid-ul copilului. De exemplu:
$ ./ forkls
My PID =41875 , Child PID =62668
Makefile collatz . c forkls . c so - lab -4. tex
collatz forkls ncollatz . c
Child 62668 finished
2. Ipoteza Collatz spune c˘a plecˆand de la orice num˘ar natural dac˘a aplic˘am
repetat urm˘atoarea operat, ie
n 7→
(
n/2 mod (n, 2) = 0
3n + 1 mod (n, 2) 6= 0
s, irul ce rezult˘a va atinge valoarea 1. Implementat, i un program care
foloses, te fork(2) s, i testeaz˘a ipoteza generˆand s, irul asociat unui num˘ar
dat ˆın procesul copil. Exemplu:
$ ./ collatz 24
24: 24 12 6 3 10 5 16 8 4 2 1.
Child 52923 finished
3. Implementat, i un program care s˘a testeze ipoteza Collatz pentru mai multe
numere date. Pornind de la un singur proces p˘arinte, este creat cˆate un
copil care se ocup˘a de un singur num˘ar. P˘arintele va as, tepta s˘a termine
execut, ia fiecare copil. Programul va demonstra acest comportament folosind funct, iile getpid(2) s, i getppid(2). Exemplu:
$ ./ ncollatz 9 16 25 36
Starting parent 6202
9: 9 28 14 7 22 11 34 17 52 26 13 40 20 10 5 16 8 4
2 1.
36: 36 18 9 28 14 7 22 11 34 17 52 26 13 40 20 10 5
16 8 4 2 1.
Done Parent 6202 Me 40018
Done Parent 6202 Me 30735
16: 16 8 4 2 1.
25: 25 76 38 19 58 29 88 44 22 11 34 17 52 26 13 40
20 10 5 16 8 4 2 1.
Done Parent 6202 Me 13388
Done Parent 6202 Me 98514
Done Parent 58543 Me 6202