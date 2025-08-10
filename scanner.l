/*
 * CMSC 430 Compiler Theory and Design
 * Project 1
 * Edmond Leaveck
 * 9 August 2025
 * Student Modified File
 * Description: Flex scanner rules for tokens defined in Tokens enumeration.
 */

%{
#include <cstdio>
#include <string>

using namespace std;

#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws		[ \t\r]+
line		[\n]

cxxcomment	\/\/[^\n]*\n	
dashcomment \-\-[^\n]*\n

digit		[0-9]
hexdig 		[0-9A-Fa-f]

id		[A-Za-z](?:[A-Za-z0-9]|_[A-Za-z0-9]|__([A-Za-z0-9]))*

dec		{digit}+
hex 	\#{hexdig}+

exp 	[eF][+\-]?{digit}+
real 	{digit}*\.{digit}+({exp})?

charnormal 		[^\\'\n]
charescape 		\\[btnrf'\\]
charlit 		\'({charnormal}|{charescape})\'

punc 		[\(\),:;]

%%

{ws}			{ECHO;}
{cxxcomment}	{ECHO; nextLine();}
{dashcomment}	{ECHO; nextLine();}
{line}			{ECHO; nextLine();}

"=>"			{ECHO; return ARROW;}
">="			{ECHO; return RELOP;}
"<="			{ECHO; return RELOP;}
"<>"			{ECHO; return RELOP;}

"="		{ECHO; return RELOP;}
">"		{ECHO; return RELOP;}
"<"		{ECHO; return RELOP;}

"|"		{ECHO; return OROP;}
"&"		{ECHO; return ANDOP;}
"!"		{ECHO; return NOTOP;}
"+"		{ECHO; return ADDOP;}
"-"     { ECHO; return ADDOP; }   
"*"     { ECHO; return MULOP; }
"/"     { ECHO; return MULOP; }   
"%"     { ECHO; return REMOP; }
"^"     { ECHO; return EXPOP; }
"~"     { ECHO; return NEGOP; } 

begin 	{ ECHO; return BEGIN_; }
case 		{ECHO; return CASE;}
character 	{ECHO; return CHARACTER;}
else            { ECHO; return ELSE; }
elsif           { ECHO; return ELSIF; }
end             { ECHO; return END; }
endfold         { ECHO; return ENDFOLD; }
endif           { ECHO; return ENDIF; }
endswitch       { ECHO; return ENDSWITCH; }
fold            { ECHO; return FOLD; }
function        { ECHO; return FUNCTION; }
if              { ECHO; return IF; }
integer         { ECHO; return INTEGER; }
is              { ECHO; return IS; }
left            { ECHO; return LEFT; }
list            { ECHO; return LIST; }
of              { ECHO; return OF; }
others          { ECHO; return OTHERS; }
real            { ECHO; return REAL; }
returns         { ECHO; return RETURNS; }
right           { ECHO; return RIGHT; }
switch          { ECHO; return SWITCH; }
then            { ECHO; return THEN; }
when            { ECHO; return WHEN; }

{real}			{ECHO; return REAL_LITERAL;  }
{hex}			{ECHO; return INT_LITERAL; }
{dec}			{ ECHO; return INT_LITERAL; }
{charlit}		{ ECHO; return CHAR_LITERAL; }
{id}			{ ECHO; return IDENTIFIER; }

{punc}			{ ECHO; return yytext[0]; }

.				{ ECHO; appendError(LEXICAL, string("Invalid Character ") + yytext); }

%%

int main() 
{
	firstLine();

	FILE *file = fopen("lexemes.txt", "w");
	if (!file)
	{
		appendError(LEXICAL, "Unable to open lexemes.txt for writing");
	}

	int token;
	while ((token = yylex()) != 0)
	{
		if (file)
		{
			fprintf(file, "%d %s\n", token, yytext);
			fflush(file);
		}
	}

	int total = lastLine();
	if (file)
	{
		fclose(file);
	}

	return total ? 1 : 0;
}