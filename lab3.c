#include <stdio.h>
#include <stdlib.h>

extern int f(int * arr1, int * arr2, int arrLength);

int main(int argc, char ** argv)
{
    if (argc != 3)
    {
        printf("Usage: %s <input filename> <size of arrays>\n", argv[0]);
        return 1;        
    }

	size_t arrLen = atoi(argv[2]);

	int * arr1 = malloc(arrLen * sizeof(int)), * arr2 = malloc(arrLen * sizeof(int));

	FILE * inputFile = fopen("arr.txt", "r");
	
	for (int i = 0; i < arrLen; ++i)
	{
		fscanf(inputFile, "%d", &arr1[i]);
	}

	for (int i = 0; i < arrLen; ++i)
	{
		fscanf(inputFile, "%d", &arr2[i]);
	}
	
    fclose(inputFile);

	printf("Result: %d\n", f(arr1, arr2, arrLen));

    free(arr1);
    free(arr2);

	return 0;
}