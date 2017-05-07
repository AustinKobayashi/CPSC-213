int x[8] = {1, 2, 3, -1, -2, 0, 184, 340057058};
int y[8];

int f(int arg0){
    
    int n = 0;
    
    while(arg0 != 0){

        if((arg0 & -2147483648) != 0)
            n++;
        
        arg0 = arg0 * 2;        
    }

    return n;
}

int main(){
    
   for(int i = 7; i >= 0; i--){
        
        y[i] = f(x[i]);
   }
    
    for(int i = 0; i < 8; i++)
        printf("%i\n", x[i]);
    
    for(int i = 0; i < 8; i++)
        printf("%i\n", y[i]);

}
