#include <iostream>
using namespace std;


void xchp(int &a,int &b)
{
 int c;
 c = b;
 b = a;
 a = c;
}


int main()
{
 int x[6] = { 12,11,99,28,70,16 };

 for (int i = 5; i >= 0; i--)
 {
  for (int y = i; y >= 0; y--)
  {
   if (x[i] < x[y])
   {
    xchp(x[i], x[y]);
   }
  }
 }


 
 for (int i = 0; i <= 5; i++)
 {
  cout << x[i] << " ";
 }

}