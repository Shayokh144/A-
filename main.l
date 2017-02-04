/* C Declarations */

%{
	#include<stdio.h>
	#include "main.tab.h"
	#include<stdlib.h>
	
	extern int yylval;

%}

/*RE and Action*/

%%
"int"	{ return INT; }
"float"	{ return FLOAT; }
"char"	{ return CHAR; }

[0-9]+	{ 
		yylval = atoi(yytext);
		return NUM;
	}

[a-z]	{
		yylval = *yytext - 'a';
		return	VAR;
	}

"IFC"		{ return IF;		}
"OR"		{ return ELSE;		}
"ELIF"      {  return ELSEIF;}

"=="        {return EQ;}



"GT"   {return GRT;}
"LT"   { return LST;}

"RBT"         {return DANB;}
"LBT"          {return BAMB;}

"LP"        {return LLP; }
"RP"         {return RRP;}

"cm"      {return CM;}
"smc"    {return SMC;}
"sin"   {return SIN;}

[-+/*^] {
		yylval = yytext[0];
		return *yytext;
		}

"main"	{ return MAIN; }

[ \t\n]*	;

.	{
		yyerror("Unknown Character.\n");
	}
%%

/* user subroutines */

int main()
{
	yyin = freopen("a.txt","r",stdin);
	yyout = freopen("out.txt","w",stdout);
	yyparse();

}

