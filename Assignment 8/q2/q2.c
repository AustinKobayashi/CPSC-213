int arr[4] = {0, 0, 0, 0};

int q2 (int arg0, int arg1, int arg2){
    
    if(arg0 < 10 || arg0 > 18) return 0;

    switch(arg0 - 10){
        case 0:
            arg2 += arg1;
            break;
        case 1:
            arg2 = 0;
            break;
        case 2:
            arg2 = arg1 - arg2;
            break;
        case 3:
            arg2 = 0;
            break;
        case 4:
            if(arg1 > arg2)
                arg2 = 1;
            else
                arg2 = 0;
            
            break;
        case 5:
            arg2 = 0;
            break;
        case 6:
            if(arg2 > arg1)
                arg2 = 1;
            else
                arg2 = 0;
            
            break;
        case 7:
            arg2 = 0;
            break;
        case 8:
            if(arg2 == arg1)
                arg2 = 1;
            else
                arg2 = 0;
            
            break;
    }
    
    return arg2;
}


int main(){
    
    arr[3] = q2(arr[0], arr[1], arr[2]);
}








