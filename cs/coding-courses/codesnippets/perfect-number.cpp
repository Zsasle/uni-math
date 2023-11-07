#include <cmath>
#include <iostream>
#include <limits.h>
#include <chrono>

int main(int argc, char* argv[]) {
	unsigned long long j = 0;
	auto start1 = std::chrono::steady_clock::now();
	auto start2 = std::chrono::steady_clock::now();
	auto stop2 = std::chrono::steady_clock::now();
	auto stop1 = std::chrono::steady_clock::now();
	auto diff = stop2 - start2;
	for (int i = 1; i < 1000000; ++i) {
		start2 = std::chrono::steady_clock::now();
		//for (unsigned long long k = 0; k < ULLONG_MAX/1000000; ++k) {
		//#pragma omp parallel for
		for (unsigned long long k = 0; k < 1000000000; ++k) {
			++j;
		}
		stop2 = std::chrono::steady_clock::now();
		diff = stop2 - start2;
		std::cout << std::chrono::duration <double, std::milli> (diff).count() << "ms" << std::endl;
		std::cout << j << std::endl;
	}
	stop1 = std::chrono::steady_clock::now();
	diff = stop1 - start1;
	std::cout << std::chrono::duration <double, std::milli> (diff).count() << "ms" << std::endl;
}
