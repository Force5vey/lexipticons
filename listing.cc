/*
 * CMSC 430 Compiler Theory and Design
 * Project 1
 * Edmond Leaveck
 * 9 August 2025
 * Student Modified File
 * Description: Implements functions that produce the compilation listing.
 */

#include <cstdio>
#include <string>
#include <vector>

#include "listing.h"

static int lineNumber;

static std::vector<std::string> errorQueue;
static int lexicalErrors = 0;
static int syntaxErrors = 0;
static int semanticErrors = 0;

static void displayErrors();

void firstLine()
{
	lineNumber = 1;
	printf("\n%4d  ", lineNumber);
}

void nextLine()
{
	displayErrors();
	lineNumber++;
	printf("%4d  ", lineNumber);
}

int lastLine()
{
	printf("\r");
	displayErrors();

	const int totalErrors = lexicalErrors + syntaxErrors + semanticErrors;
	if (totalErrors == 0)
	{
		printf("Compiled Successfully\n");
	}
	else
	{
		printf("Lexical Errors %d\n", lexicalErrors);
		printf("Syntax Errors %d\n", syntaxErrors);
		printf("Semantic Errors %d\n", semanticErrors);
	}

	return totalErrors;
}

void appendError(ErrorCategories errorCategory, std::string message)
{
	const char *prefix[] = {
		"Lexical Error, ",
		"Syntactic Error, ",
		"Semantic Error, ",
		"Semantic Error, Duplicate ",
		"Semantic Error, Undeclared "};

	switch (errorCategory)
	{
	case LEXICAL:
		lexicalErrors++;
		break;
	case SYNTAX:
		syntaxErrors++;
		break;
	case GENERAL_SEMANTIC:
	case DUPLICATE_IDENTIFIER:
	case UNDECLARED:
		semanticErrors++;
		break;
	}

	errorQueue.push_back(prefix[errorCategory] + message);
}

void displayErrors()
{
	for (const auto &msg : errorQueue)
	{
		printf("%s\n", msg.c_str());
	}
	errorQueue.clear();
}
