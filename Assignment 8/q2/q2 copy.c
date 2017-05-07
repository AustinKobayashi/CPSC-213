int arr[4] = {0, 0, 0, 0};

int foo (int arg0, int arg1, int arg2){
    
    static const void* jumpTable[4] = { &&J330, &&J384, &&J334, &&J384, &&J33C, 
        &&J384, &&J354, &&J384, &&J36C};
    
    if(arg0 < 10 || arg0 > 18) goto L6;
    goto *jumpTable[arg0-10];
    
J330:
    arg2 += arg1;
    goto L7;
    
J334:
    arg2 = arg1 - arg2;
    goto L7;
    
J33C:
    if(arg1 > arg2)
        arg2 = 1;
    else
        arg2 = 0;
    
    goto L7;
    
J354:
    if(arg2 > arg1)
        arg2 = 0;
    else
        arg2 = 1;
    
    goto L7;
    
J36C:
    if(arg2 == arg1)
        arg2 = 1;
    else
        arg2 = 0;
    
    goto L7;

J384:
    
L6:
    arg2 = 0; 
    goto L7;
    
L7:
    return arg2;

}


void main(){
    
    arr[3] = foo(arr[0], arr[1], arr[2]);
}








