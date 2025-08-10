/*
 * CMSC 430 Compiler Theory and Design
 * Project 1
 * Edmond Leaveck
 * 9 August 2025
 * Student Modified File
 * Description: Function prototypes for the compilation listing.
 */

#include <string>

enum ErrorCategories
{
	LEXICAL,
	SYNTAX,
	GENERAL_SEMANTIC,
	DUPLICATE_IDENTIFIER,
	UNDECLARED
};

void firstLine();
void nextLine();
int lastLine();

void appendError(ErrorCategories errorCategory, std::string message);
