#include <sum/sum.hpp>
#include <assert.h>

int main()
{
	int x = 3;
	int y = 34;
	int z = sum(x, y);
	int expected = x + y;

	assert(z == expected);

	return 0;
}