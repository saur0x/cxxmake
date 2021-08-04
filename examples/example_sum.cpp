#include <sum/sum.hpp>
#include <iostream>


int main()
{
	int x = 3;
	int y = 34;
	int z = sum(x, y);

	std::cout << z << std::endl;

	return 0;
}