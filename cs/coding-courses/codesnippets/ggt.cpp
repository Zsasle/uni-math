#include <iostream>

int ggT(int a, int b) {
	if (a < b) {
		int x = a;
		a = b;
		b = x;
	}
	int t = -1;
	if (b == 0) {
		return a;
	}
	return ggT(b, a % b);
}

int main(int argc, char* argv[]) {
	if(argc != 3) {
		std::cout << "This programm needs 2 args\n";
		return 1;
	}
	std::cout << ggT(atoi(argv[1]), atoi(argv[2])) << "\n";
	return 0;
}
