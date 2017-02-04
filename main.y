/* C Declarations */

%{
	#include<stdio.h>
	#include<math.h>
	
	#define PI 3.14159265
	int sym[26];
	int a,b;
	int c=1;
	int sum;
	int flg=0;
	
%}

/* BISON Declarations */

%token NUM VAR IF ELSE MAIN INT FLOAT CHAR LST GRT EQ DANB BAMB LLP RRP CM SMC SIN ELSEIF
%nonassoc IFX
%nonassoc ELSEIF
%nonassoc ELSE
%left EQ
%left LST GRT
%left '+' '-'
%left '*' '/'
%left SIN
%left '^'
%left LLP RRP BAMB DANB
/* Simple grammar rules */

%%

program: MAIN LLP RRP BAMB cstatement DANB
	 ;

cstatement: /* empty */

	| cstatement statement
	
	| cdeclaration
	;
	
cdeclaration:	TYPE ID1 SMC	{ printf("\nvalid declaration\n"); }
			;
			
TYPE : INT

     | FLOAT

     | CHAR
     ;

ID1  : ID1 CM VAR

     |VAR
     ;

statement: SMC

	| expression SMC 			{ if(flg!=1) printf("value of the expression: %d\n", $1); }

        | VAR EQ expression SMC 		{ 
							sym[$1] = $3; 
							printf("Value of the variable: %d\t\n",$3);
						}

	| IF LLP expression RRP expression SMC %prec IFX {
								if($3)
								{
									printf("\nvalue of expression in IF: %d\n",$5);
								}
								else
								{
									printf("condition value zero in IF block\n");
								}
							}

	| IF LLP expression RRP expression SMC ELSE expression SMC {
								 	if($3)
									{
										printf("value of expression in IF: %d\n",$5);
									}
									else
									{
										printf("value of expression in ELSE: %d\n",$8);
									}
								   }
								   
								   
	| IF LLP expression RRP  BAMB  IF LLP expression RRP expression SMC ELSE expression SMC   DANB  ELSE expression SMC {
								 	if($3)
									{
										if($8)
										printf("value of expression in IF: %d\n",$10);
										else
										printf("value of expression in ELSE: %d\n",$13);
									}
									else
									{
										printf("value of expression in ELSE: %d\n",$17);
									}
								   }
								   
								   
								   
								   
								   
								   
	| IF LLP expression RRP expression SMC ELSEIF LLP expression RRP expression SMC ELSE expression SMC {
								 	if($3)
									{
										printf("value of expression in IF: %d\n",$5);
									}
									
									else if($9)
									{
									printf("value of expression in ELSEIF: %d\n",$11);
									}
									else
									{
										printf("value of expression in ELSE: %d\n",$8);
									}
								   }							   
								   
								   
								   
								   
	;

expression: NUM				{ $$ = $1; 	}

	| VAR				{ $$ = sym[$1]; }

	| expression '+' expression	{ $$ = $1 + $3; }
	| expression '^' expression	{ sum=1;
for(c=1;c<=$3;c++)
{

sum=sum*$1;

}
$$=sum;
}

	| expression '-' expression	{ $$ = $1 - $3; }

	| expression '*' expression	{ $$ = $1 * $3; }

	| expression '/' expression	{ 	if($3) 
				  		{
				     			$$ = $1 / $3;
				  		}
				  		else
				  		{
							$$ = 0;
							printf("\ndivision by zero\t");
				  		} 	
				    	}

	| expression LST expression	{ $$ = $1 < $3; }
	
	| SIN LLP expression RRP {  double  ret, val;val = PI / 180;ret = sin($3*val);$1=$3 ; printf("%lf\n",ret);flg=1; }

	| expression GRT expression	{ $$ = $1 > $3; }
	
	| LLP expression RRP		{ $$ = $2;	}
	;
%%

int yywrap()
{
return 1;
}


yyerror(char *s){
	printf( "%s\n", s);
}

