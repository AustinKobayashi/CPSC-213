int arr[10] = {0,0,0,0,0,0,0,0,0,0};

void add(int arg3, int arg4){
    
    arr[arg4] = arr[arg4] + arg3;
}

void foo(int arg0, int arg1){
    
    add(3, 4);
    add(arg0, arg1);
}

int main(){
    
    foo(1,2);
    
    for(int i = 0; i < 10; i++)
        printf("%i\n", arr[i]);
        
}
