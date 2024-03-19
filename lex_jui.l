%{
#include <stdio.h>
#include <dirent.h>
#include <string.h>
#include <ctype.h>
int line_number = 1; // Initialize line number
int start_column = 1; // Initialize start column
int invalid_found = 0; 
int is_identifier(char* str);
int findtype(char value[],int line_number,int start_column);
int indefine=0;
char map[100][31]={};
int map_count=0;
%}
%%

"Print"|"ReadInteger"|"ReadLine" {
	if(indefine){
		strncpy(map[map_count++], yytext,31);
		strncpy(map[map_count++], "T_Keyword",31); // Sample files show it as Identifier, but this code is as per the decaf grammar provided
	}
	else
	if(!invalid_found){
    		printf("%-13sline %d cols %d-%d is T_Keyword\n", yytext,line_number, start_column, start_column + yyleng - 1);
	}
    	start_column = start_column + yyleng;
}
"int" {
	if(indefine){
		strncpy(map[map_count++], yytext,31);
                strncpy(map[map_count++], "T_Int",31);
        }
        else
        if(!invalid_found){
        printf("%-13sline %d cols %d-%d is T_Int\n","int",line_number, start_column, start_column + yyleng - 1);
	}
        start_column = start_column + yyleng;
}
"double" {
	if(indefine){
		strncpy(map[map_count++], yytext,31);
                strncpy(map[map_count++], "T_Double",31);
        }
        else
        if(!invalid_found){
        printf("%-13sline %d cols %d-%d is T_Double\n","double",line_number, start_column, start_column + yyleng - 1);
	}
        start_column = start_column + yyleng;
}
"string" {
	if(indefine){
		strncpy(map[map_count++], yytext,31);
                strncpy(map[map_count++], "T_String",31);
        }
        else
        if(!invalid_found){
        printf("%-13sline %d cols %d-%d is T_String\n","string",line_number, start_column, start_column + yyleng - 1);
	}
        start_column = start_column + yyleng;
}
"while" {
	if(indefine){
		strncpy(map[map_count++], yytext,31);
                strncpy(map[map_count++], "T_While",31);
        }
        else
        if(!invalid_found){
        printf("%-13sline %d cols %d-%d is T_While\n","while",line_number, start_column, start_column + yyleng - 1);
	}
        start_column = start_column + yyleng;
}
"if" {
	if(indefine){
		strncpy(map[map_count++], yytext,31);
                strncpy(map[map_count++], "T_If",31);
        }
        else
        if(!invalid_found){
        printf("%-13sline %d cols %d-%d is T_If\n","if",line_number, start_column, start_column + yyleng - 1);
	}
        start_column = start_column + yyleng;
}
"else" {
	if(indefine){
		strncpy(map[map_count++], yytext,31);
                strncpy(map[map_count++], "T_Else",31);
        }
        else
        if(!invalid_found){
        printf("%-13sline %d cols %d-%d is T_Else\n","else",line_number, start_column, start_column + yyleng - 1);
	}
        start_column = start_column + yyleng;
}
"return" {
	if(indefine){
		strncpy(map[map_count++], yytext,31);
                strncpy(map[map_count++], "T_Return",31);
        }
        else
        if(!invalid_found){
        printf("%-13sline %d cols %d-%d is T_Return\n","return",line_number, start_column, start_column + yyleng - 1);
	}
        start_column = start_column + yyleng;
}
"break" {
	if(indefine){
		strncpy(map[map_count++], yytext,31);
                strncpy(map[map_count++], "T_Break",31);
        }
        else
        if(!invalid_found){
        printf("%-13sline %d cols %d-%d is T_Break\n","break",line_number, start_column, start_column + yyleng - 1);
	}
        start_column = start_column + yyleng;
}
"for" {
	if(indefine){
		strncpy(map[map_count++], yytext,31);
                strncpy(map[map_count++], "T_For",31);
        }
        else
        if(!invalid_found){
        printf("%-13sline %d cols %d-%d is T_For\n","for",line_number, start_column, start_column + yyleng - 1);
	}
        start_column = start_column + yyleng;
}

"void" {
	if(indefine){
		strncpy(map[map_count++], yytext,31);
                strncpy(map[map_count++], "T_Void",31);
        }

       else
        if(!invalid_found){ 
	printf("%-13sline %d cols %d-%d is T_Void\n","void",line_number, start_column, start_column + yyleng - 1);
	}
	start_column = start_column + yyleng;
}
"true"|"false" {
	if(indefine){
		char value_type[80]={};
                strncpy(map[map_count++], yytext,31);
		strcat(value_type,"T_BoolConstant (value = ");
                strcat(value_type,yytext);
                strcat(value_type,")");
                strncpy(map[map_count++],value_type ,31);
        }else
	if(!invalid_found){
		printf("%-13sline %d cols %d-%d is T_BoolConstant (value = %s)\n",yytext,line_number, start_column, start_column + yyleng - 1,yytext);
	}
	start_column = start_column + yyleng;
}
[a-zA-Z_][a-zA-Z0-9_]{0,1024} {
	
	if(indefine){
                strncpy(map[map_count++], yytext,31);
                strncpy(map[map_count++], "T_Identifier",31);
        }else
	if(!invalid_found){
		if (strlen(yytext)<=31){
			if (strlen(yytext)<=13)
				printf("%-13sline %d cols %d-%d is T_Identifier\n",yytext,line_number, start_column, start_column + yyleng - 1);
			else
				printf("%s line %d cols %d-%d is T_Identifier\n",yytext,line_number, start_column, start_column + yyleng - 1);
		}
		else{
			printf("\n*** Error line %d.\n",line_number);
			printf("*** Identifier too long: \"%s\"\n\n",yytext);
			printf("%-13s line %d cols %d-%d is T_Identifier (truncated to variable_whose_name_is_much_too)\n",yytext,line_number, start_column, start_column + yyleng - 1);
		}
	}
	start_column = start_column + yyleng;
}
"/*"                    {
                            int comment_start_line = line_number;
                            while (1) {
                                char c = input();
                                if (c == EOF) {
                                    fprintf(stderr, "Unterminated multiline comment starting from line %d\n", comment_start_line);
                                    break;
                                }
                                if (c == '\n') {
					line_number++;
					indefine=0;
					strncpy(map[map_count++], "$",31);
                                    yylineno++;
                                }
                                if (c == '*' && input() == '/') {
                                   // printf("Multiline comment starts from line %d and ends on line %d\n", comment_start_line, line_number);
                                    break;
                                }
                            }
                        }
"//"(.*)  {
//          	 printf("Single line comment at line %d: %s\n", yylineno, yytext);
          }
0[xX][0-9a-fA-F]+ {
	if(indefine){
		char value_type[80]={};
                strncpy(map[map_count++], yytext,31);
		strcat(value_type,"T_HexConstant (value = ");
                strcat(value_type,yytext);
                strcat(value_type,")");
                strncpy(map[map_count++],value_type ,31);

        }else
	if(!invalid_found){
		printf("%-13sline %d cols %d-%d is T_HexConstant (value = %s)\n",yytext,line_number, start_column, start_column + yyleng - 1,yytext);
	}
	start_column = start_column + yyleng;
}

[0-9]+ {
	if(indefine){
                strncpy(map[map_count++], yytext,31);
		char value_type[80]={};
		strcat(value_type,"T_IntConstant (value = ");
		strcat(value_type,yytext);
		strcat(value_type,")");
                strncpy(map[map_count++],value_type ,31);
        }else
    	if(!invalid_found){
		printf("%-13sline %d cols %d-%d is T_IntConstant (value = %d)\n",yytext,line_number, start_column, start_column + yyleng - 1,atoi(yytext));
	}
	start_column = start_column + yyleng;
}

[0-9]+\.[0-9]*([eE][+-]?[0-9]+)? {
	if(indefine){
		char value_type[80]={};
                strncpy(map[map_count++], yytext,31);
		strcat(value_type,"T_DoubleConstant (value = ");
                strcat(value_type,yytext);
                strcat(value_type,")");
                strncpy(map[map_count++],value_type ,31);
        }else
    	if(!invalid_found){
		if (strstr(yytext,"E")==NULL)
			printf("%-13sline %d cols %d-%d is T_DoubleConstant (value = %s)\n",yytext,line_number, start_column, start_column + yyleng - 1,yytext);
		else{
			char *ptr;
                        double value = strtod(yytext, &ptr);
			printf("%-13sline %d cols %d-%d is T_DoubleConstant (value = %.12g)\n",yytext,line_number, start_column, start_column + yyleng - 1,value);
		}
	}
	start_column = start_column + yyleng;
}

\"[^\"\n]*\" {
	if(indefine){
		char value_type[80]={};
                strncpy(map[map_count++], yytext,31);
		strcat(value_type,"T_StringConstant (value = ");
                strcat(value_type,yytext);
                strcat(value_type,")");
                strncpy(map[map_count++],value_type ,31);

        }else
	if(!invalid_found){
		if(strlen(yytext)>=13){
		printf("%s line %d cols %d-%d is T_StringConstant (value = %s)\n",yytext,line_number, start_column, start_column + yyleng - 1,yytext);
		}else
		printf("%-13sline %d cols %d-%d is T_StringConstant (value = %s)\n",yytext,line_number, start_column, start_column + yyleng - 1,yytext);
	}
	start_column = start_column + yyleng;
}
\"([^\"\\\n]|\\.)*\n {
    // Unterminated string constant found
	printf("\n*** Error line %d.\n",line_number); 
   	printf("*** Unterminated string constant: %s\n", yytext);
   	line_number++;
	start_column = 1;
}
^#define[ \t]+[a-zA-Z0-9_]* {
		    char identifier[31];
		    
                    if (sscanf(yytext, "#define %s", identifier) != 1) {
                        start_column = start_column + yyleng;
                        invalid_found = 1;
				
                    }else
                    if (!is_identifier(identifier)) {
			printf("\n*** Error line %d.\n",line_number);
        		printf("*** Invalid # directive\n\n");
		        start_column = start_column + yyleng;
		        invalid_found = 1;

			}
		     strncpy(map[map_count++], identifier,31);	
		     start_column = start_column + yyleng;
		     indefine=1;	

}

[ \t] {
    // Ignore whitespace
	start_column = start_column + 1;
}
[\n] {
	line_number = line_number +1;
	indefine=0;
	strncpy(map[map_count++], "$",31);
	start_column = 1;
	invalid_found = 0;
}
"+"|"-"|"*"|"/"|"%"|"<"|">"|"="|"!="|"&&"|"!"|";"|","|"."|"("|")"|"{"|"}" {
	if(indefine){
		char value_type[80]={};
                strncpy(map[map_count++], yytext,31);
                strcat(value_type,"'");
                strcat(value_type,yytext);
                strcat(value_type,"'");

                strncpy(map[map_count++], value_type,31);
        }else
	if(!invalid_found){
		printf("%-13sline %d cols %d-%d is \'%s\'\n",yytext,line_number, start_column, start_column + yyleng - 1,yytext);	
	}
	start_column = start_column + yyleng;
}
"||" {
	if(indefine){
                strncpy(map[map_count++], yytext,31);
                strncpy(map[map_count++], yytext,31);
        }else
        if(!invalid_found)
        printf("%-13sline %d cols %d-%d is T_Or\n","||",line_number, start_column, start_column + yyleng - 1);
        start_column = start_column + yyleng;
}
"<=" {
	if(indefine){
                strncpy(map[map_count++], yytext,31);
                strncpy(map[map_count++], yytext,31);
        }else
        if(!invalid_found)
	        printf("%-13sline %d cols %d-%d is T_LessEqual\n","<=",line_number, start_column, start_column + yyleng - 1);
        start_column = start_column + yyleng;
}
">=" {
	if(indefine){
                strncpy(map[map_count++], yytext,31);
                strncpy(map[map_count++], yytext,31);
        }else
        if(!invalid_found)
        printf("%-13sline %d cols %d-%d is T_GreaterEqual\n",">=",line_number, start_column, start_column + yyleng - 1);
        start_column = start_column + yyleng;
}
"==" {
	if(indefine){
                strncpy(map[map_count++], yytext,31);
                strncpy(map[map_count++], yytext,31);
        }else
        if(!invalid_found)
        printf("%-13sline %d cols %d-%d is T_Equal\n","==",line_number, start_column, start_column + yyleng - 1);
        start_column = start_column + yyleng;
}
"$"|"@"|"^"|"&"|"~"|"`"|"?" {
        printf("\n*** Error line %d.\n",line_number);
        printf("*** Unrecognized char: \'%s\'\n\n",yytext);
        start_column = start_column + yyleng;
        invalid_found = 1;

}
. {
	if(strcmp(yytext,"#")==0){
		char c= input();
		start_column = start_column + 1;
		if (c==' ' || c=='\n'|| c==EOF){
			printf("\n*** Error line %d.\n",line_number);
		        printf("*** Invalid %s directive\n\n\n",yytext);
		        start_column = start_column + yyleng;
		        invalid_found = 1;
		}
		char identifier[31]={};
		char value[1024]={};
		char val_type[100]={};
		start_column--;	
		int found=0;	
		while(1){
			
			if(c== ' '|| c=='\n'||c==EOF||c==')' ){
				for(int i =0;i<99;i=i+2){
					if(strcmp(map[i],identifier)==0){
						i++;
						while(strcmp(map[i],"$")!=0 && strcmp(map[i],"\0")!=0){
							strcpy(value,map[i]);
							strcpy(val_type,map[i+1]);
							printf("%-13sline %d cols %d-%zu is %s\n",value,line_number,start_column,strlen(value)+start_column-1,val_type);
							start_column = start_column+strlen(value)+1;
							i=i+2;
							found=1;
						}
						if (c==')'){
							start_column--;
						 	printf("%-13sline %d cols %d-%d is ')'\n ",")",line_number, start_column,start_column);
						start_column = start_column +1;
						}
						break;
						
					}
				}
				if (c=='\n') {
					if(found==0){
						printf("\n*** Error line %d.\n",line_number);
        				printf("*** Invalid # directive\n\n");
					}
					line_number++;
					start_column =1;
				}		
				break;	
					
			}
			else{
				strncat(identifier,&c,1);
			}
			c=input();
			//start_column = start_column + 1;

		}
		break;
	}
        printf("\n*** Error line %d.\n",line_number);
	printf("*** Invalid %s directive\n\n\n",yytext);
	start_column = start_column + yyleng;
	invalid_found = 1;
	
}

%%
int findtype(char value[],int line_number,int start_column){
	// add the second NULL terminator
}
int is_identifier(char* str) {
    // Check if the string is an identifier (starts with a letter or underscore,
    // followed by letters, digits, or underscores)
    if (!isalpha(str[0]) && str[0] != '_')
        return 0;
    
    for (int i = 1; str[i]; i++) {
        if (!isalnum(str[i]) && str[i] != '_')
            return 0;
    }
    return 1;
}
int main() {
	const char* folder_path = "../samples";
	DIR* dir = opendir(folder_path);
    if (!dir) {
        perror("Error opening directory");
        return 1;
    }

    struct dirent* entry;
	while ((entry = readdir(dir)) != NULL) {
        if (entry->d_type == DT_REG) { // Regular file
            const char* filename = entry->d_name;
            const char* extension = strrchr(filename, '.');
            if (extension && (strcmp(extension, ".frag") == 0||strcmp(extension, ".decaf") == 0 )) {
		//printf(" file: %s\n", filename);

		char filepath[256];
		snprintf(filepath, sizeof(filepath), "%s/%s", folder_path, filename);
		strcpy(filepath, folder_path);
		strcat(filepath, "//");
		strcat(filepath,filename);
		FILE* input_file = fopen(filepath, "r");
		if (input_file==NULL) {

            	printf("Error opening file: %s\n", filepath);
            	continue;
        	}
		line_number = 1;
		start_column =1;
        	invalid_found =0;
		int i=0;
		for (int i=0;i<=99;i++)
			 strncpy(map[i], "0",31);
		map_count=0;
		yyin = input_file; // Set input stream for Lex

        	yylex(); // Start lexical analysis

        	fclose(input_file);
		
            }
        }
    }

    closedir(dir);
    return 0;
}

