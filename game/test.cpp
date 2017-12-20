#include <iostream>
using namespace std;
void print_square(int high,int weigth)
{
    int col = 10;
    for(int i=0;i<high;i++)
    {
        for(int k=0;k<weigth;k++)
        {
            cout<<"*";
        }
        for(int n=0;n<col;n++)
        {
            bool flag = 0;
            for(int j=0;j<weigth;j++)
            {
                if(i == j  || i==(col-j-1))
                {
                    flag = 1;
                }
            }
            if (flag == 1 )
            {
                cout<<"*";
            }
            else
            {
                cout<<" ";
            }
        }
        for (int k = 0; k < weigth; k++)
        {
            cout << "*";
        }
        cout<<endl;
    }
}
int main()
{
    print_square(20,3);
    return 0;
}