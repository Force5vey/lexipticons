/*
 * CMSC 430 Compiler Theory and Design
 * Project 1
 * Edmond Leaveck
 * 9 August 2025
 * Student Modified File
 * Description: Added additional tokens to the Tokens enumeration.
 */

//
// Tokens enumeration
// Defines all token types recognized by the compiler's lexer.
//
enum Tokens
{
    ADDOP = 256,
    MULOP,
    ANDOP,
    OROP,  // |
    NOTOP, // !
    RELOP, // = <> > >= < <=
    REMOP, // %
    EXPOP, // ^
    NEGOP, // ~

    ARROW, // =>
    BEGIN_,
    CASE,
    CHARACTER,
    ELSE,
    ELSIF,
    ENDFOLD,
    ENDIF,
    END,
    ENDSWITCH,
    FOLD,
    FUNCTION,
    IF,
    INTEGER,
    IS,
    LEFT,
    LIST,
    OF,
    OTHERS,
    REAL,
    RETURNS,
    RIGHT,
    SWITCH,
    THEN,
    WHEN,

    IDENTIFIER,
    INT_LITERAL,
    REAL_LITERAL,
    CHAR_LITERAL
};
