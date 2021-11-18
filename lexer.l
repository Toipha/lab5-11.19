%option noyywrap
%{
    #define YY_NO_UNPUT
    #define YY_NO_INPUT
    #include <string>
	#include<math.h>
    #include "parser.h"
    #include <ostream>
    #include <fstream>

    using namespace std;

    extern FILE *yyin; 
    extern FILE *yyout;
    extern bool dump_tokens;

    void DEBUG_FOR_LAB4(std::string s){
        std::string DEBUG_INFO = "[DEBUG LAB4]: \t" + s + "\n";
        fputs(DEBUG_INFO.c_str(), yyout);
    }
%}

ID [a-zA-Z_][a-zA-Z_0-9]*
DECIMIAL ([1-9][0-9]*|0)
HEX 0[xX][0-9a-fA-F]+
OCT [0][0-7]+

EOL (\r\n|\n|\r)
WHITE [\t ]


LINECOMMENT \/\/[^\n]*
BLOCKCOMMENT "/*"([^*]|\*+[^*/])*\*+"/"

%%

"int" {
    /*
    * Questions: 
    *   Q1: Why we need to return INT in further labs?
    *   Q2: What is "INT" actually?
    */
    if(dump_tokens)
        DEBUG_FOR_LAB4("INT\tint");
    return INT;
}
"void" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("VOID\tvoid");
    return VOID;
}
"if" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("IF\tif");
    return IF;
};
"else" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("ELSE\telse");
    return ELSE;
};
"return" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("RETURN\treturn");
    return RETURN;
}

"while" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("WHILE\twhile");
    return WHILE;
}
"=" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("ASSIGN\t=");
    return ASSIGN;
}
"<" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("LESS\t<");
    return LESS;
}
"+" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("ADD\t+");
    return ADD;
}
"-" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("SUB\t-");
    return SUB;
}
"*" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("MUL\t*");
    return MUL;
}
"/" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("DIV\t/");
    return DIV;
}
"%" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("MOD\t/");
    return MOD;
}
"&&" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("AND\t+");
    return AND;
}
";" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("SEMICOLON\t;");
    return SEMICOLON;
}
"(" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("LPAREN\t(");
    return LPAREN;
}
")" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("RPAREN\t)");
    return RPAREN;
}
"{" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("LBRACE\t{");
    return LBRACE;
}
"}" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("RBRACE\t}");
    return RBRACE;
}

{DECIMIAL} {
    if(dump_tokens)
        DEBUG_FOR_LAB4(yytext);
    yylval.itype = atoi(yytext);
    return INTEGER;
}
{HEX} {
    if(dump_tokens)
        DEBUG_FOR_LAB4(yytext);
    std::string val=yytext;	
	int dec=0;
	int len = val.length();
	for(int i=len-1; i>1; i--)
	{
		if(val[i]>='A' && val[i]<='F')
		{
			int slice = val[i]-'A'+ 10;
			slice = slice * pow(16, len-i-1);
			dec+=slice;
		}
		else		{
		int slice = val[i]-'0';
			slice = slice * pow(16, len-i-1);
			dec+=slice;
			}
		}
        yylval.itype=dec;
        return INTEGER;
}
{OCT} {
     if(dump_tokens)
        DEBUG_FOR_LAB4(yytext);
    std::string val=yytext;	
	int oct=0;
	int len = val.length();
	for(int i=len-1; i>1; i--)
	{
		if(val[i]>='A' && val[i]<='F')
		{
			int slice = val[i]-'A'+ 10;
			slice = slice * pow(16, len-i-1);
			oct+=slice;
		}
		else		{
		int slice = val[i]-'0';
			slice = slice * pow(16, len-i-1);
			oct+=slice;
			}
		}
        yylval.itype=oct;
        return INTEGER;
}
{ID} {
    if(dump_tokens)
        DEBUG_FOR_LAB4(yytext);
    char *lexeme;
    lexeme = new char[strlen(yytext) + 1];
    strcpy(lexeme, yytext);
    yylval.strtype = lexeme;
    return ID;
}

{EOL} yylineno++;
{WHITE}
%%
