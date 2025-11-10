module Syntax

layout Layout = WhitespaceAndComment* !>> [\ \t\n\r#];
lexical WhitespaceAndComment = [\ \t\n\r] | @category="Comment" "#" ![\n]* $;

// ===== TOKENS =====
lexical INTEGER = [0-9]+;
lexical FLOAT   = [0-9]+ "." [0-9]+;
lexical BOOLEAN = "true" | "false";
lexical CHAR    = "\'" ![\'\n] "\'";
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
  = func:     "function" IDENT "(" {Param ","}* ")" Block "end"
  | dataDecl: "data" IDENT "=" TypeDecl "end"
  | stmt:     Stmt
  ;

syntax Param = param: IDENT ;

// Un bloque con 'do' explícito
syntax Block = block: "do" Stmt* ;

// ===== SENTENCIAS =====
syntax Stmt
  = assign: IDENT "=" Expr
  | cond:   "if" Expr "then" Stmt* ("elseif" Expr "then" Stmt*)* ("else" Stmt*)? "end"
  | loop:   "for" IDENT "from" Expr "to" Expr "do" Stmt* "end"
  | callS:  IDENT "(" {Expr ","}* ")"
  ;

// ===== EXPRESIONES (con precedencia) =====
syntax Expr
  = bracket "(" Expr ")"
  > neg:     "neg" Expr
  > right (
      pow: Expr "**" Expr
    )
  > left (
      mul: Expr "*" Expr
    | div: Expr "/" Expr
    | mdl: Expr "%" Expr
    )
  > left (
      add: Expr "+" Expr
    | sub: Expr "-" Expr
    )
  > non-assoc (
      lt:  Expr "\<" Expr
    | gt:  Expr "\>" Expr
    | le:  Expr "\<=" Expr
    | ge:  Expr "\>=" Expr
    )
  > non-assoc (
      eq:  Expr "==" Expr
    | ne:  Expr "\<\>" Expr
    )
  > left and: Expr "and" Expr
  > left or:  Expr "or" Expr
  > id:      IDENT
  | intLit:  INTEGER
  | floatLit: FLOAT
  | boolLit: BOOLEAN
  | strLit:  STRING
  | call:    IDENT "(" {Expr ","}* ")"
  ;

// ===== TIPOS =====
syntax TypeDecl
  = struct: "struct" "{" Field* "}"
  | tupleType:  "tuple" "(" {TypeDecl ","}* ")"
  | basic:  IDENT
  ;

syntax Field = field: IDENT ":" TypeDecl ;