#include <iostream>
using namespace std;
void TransferBlocks(int, int *, int *);
int main()
{
    int arr1[5] = {11,22,33,44,55};
    int arr2[5] = {0,0,0,0,0};
    int arr_size = 5;
    TransferBlocks(arr_size, arr1, arr2);
    for(int i= 0; i<arr_size; i++)
    {
        cout<<arr2[i]<<"\n";
    }
    return 0;
}

void TransferBlocks(int blockSize,int *block1,int *block2)
{
    for (int i = 0; i < blockSize; i++)
    {
        *block2 = *block1;
        block1++;
        block2++;
    }
}

