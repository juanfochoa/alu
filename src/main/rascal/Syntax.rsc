module Syntax

layout Layout = WhitespaceAndComment* !>> [\ \t\n\r#];
lexical WhitespaceAndComment = [\ \t\n\r] | @category="Comment" "#" ![\n]* $;

// ===== TOKENS =====
lexical INTEGER = [0-9]+;
lexical FLOAT   = [0-9]+ "." [0-9]+;
lexical BOOLEAN = "true" | "false";
lexical CHAR    = "'" ![\'\n] "'";
lexical STRING  = "\"" ![\"\n]* "\"";

lexical IDENT   = [a-zA-Z][a-zA-Z0-9_]* \ Reserved;

keyword Reserved =
  "cond" | "do" | "data" | "elseif" | "end" | "for" | "from" | "then"
  | "function" | "else" | "if" | "in" | "iterator" | "sequence"
  | "struct" | "to" | "tuple" | "type" | "with" | "yielding"
  | "true" | "false"
  ;

// ===== RAÍZ =====
start syntax Program = program: Module* ;

// ===== MÓDULOS =====
syntax Module
  = func:     "function" IDENT "(" [Param {","}] ")" Block "end"
  | dataDecl: "data" IDENT "=" TypeDecl "end"
  | stmt:     Stmt
  ;

syntax Param = param: IDENT ;

// Un bloque es una secuencia de sentencias (lo cierra el 'end' del contenedor)
syntax Block = block: Stmt* ;

// ===== SENTENCIAS =====
syntax Stmt
  = assign: IDENT "=" Expr
  | cond:   "if" Expr "then" Block ["else" Block] "end"
  | loop:   "for" IDENT "in" Expr "do" Block "end"
  | callS:  IDENT "(" [Expr {","}] ")"
  ;

// ===== EXPRESIONES =====
syntax Expr
  = bin:  Expr Op Expr
  | neg:  "neg" Expr
  | id:   IDENT
  | int:  INTEGER
  | fl:   FLOAT
  | bool: BOOLEAN
  | str:  STRING
  | call: IDENT "(" [Expr {","}] ")"
  ;

syntax Op
  = add: "+"  | sub: "-" | mul: "*"  | div: "/"
  | pow: "**" | mod: "%"
  | lt:  "<"  | gt:  ">" | le: "<=" | ge: ">="
  | eq:  "="  | ne:  "<>"
  | and: "and" | or: "or"
  ;

// ===== TIPOS =====
syntax TypeDecl
  = struct: "struct" "{" Field* "}"
  | tuple:  "tuple" "(" [TypeDecl {","}] ")"
  | basic:  IDENT
  ;

syntax Field = field: IDENT ":" TypeDecl ;
