/*
 * Tower Of Hanoi
 *
 *  Author: Alejandro Rios
 *  Exp: is708932
 *  Date: Feb 21, 2019
 */

#include <stdlib.h>
#include <stdio.h>
#define NUMBER_OF_DISKS 5

void moveTower(int disk, int source[], int dest[], int spare[]);
int pop(int arr[]);
void push(int arr[], int value);
void printTower(int arr[], char tower);

unsigned int moves = 0;
int towerA[NUMBER_OF_DISKS];
int towerB[NUMBER_OF_DISKS];
int towerC[NUMBER_OF_DISKS];

int main() {
	for(int i = 0; i < NUMBER_OF_DISKS; i ++) {
		towerA[i] = NUMBER_OF_DISKS - i;
		towerB[i] = 0;
		towerC[i] = 0;
	}

	printTower(towerA, 'A');
	printTower(towerB, 'B');
	printTower(towerC, 'C');
	printf("\n");

	moveTower(towerA[0], towerA, towerC, towerB);

	printTower(towerA, 'A');
	printTower(towerB, 'B');
	printTower(towerC, 'C');
	printf("\nMoves: %d", moves);

	return 0;
}

void moveTower(int disk, int source[], int dest[], int spare[]) {
	if (disk == 1) {
		int temp = pop(source);
		push(dest, temp);
		moves ++;
	} else {
		moveTower(disk - 1, source, spare, dest);
		int temp = pop(source);
		push(dest, temp);
		moves ++;
		moveTower(disk - 1, spare, dest, source);
	}
}

int pop(int arr[]) {
	int temp = 0;
	int i = NUMBER_OF_DISKS - 1;
	while(i >= 0) {
		if(arr[i] != 0) {
			temp = arr[i];
			arr[i] = 0;
			break;
		}
		i = i - 1;
	}
	return temp;
}

void push(int arr[], int value) {
	int i = 0;
	while(i < NUMBER_OF_DISKS) {
		if(arr[i] == 0) {
			arr[i] = value;
			break;
		}
		i = i + 1;
	}
}

void printTower(int arr[], char tower) {
	printf("%c -- ", tower);
	for(int i = 0; i < NUMBER_OF_DISKS; i ++) {
		if(arr[i] != 0) printf("%d ", arr[i]);
	}
	printf("\n");
}
