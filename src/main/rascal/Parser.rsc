module Parser

import Syntax;
import AST;
import ParseTree;

// Parsea archivo y devuelve ParseTree
public Tree parseTree(loc file) = parse(#Program, file);

// Parsea string con origen y devuelve ParseTree
public Tree parseTree(str src, loc origin) = parse(#Program, src, origin);

// Convierte ParseTree -> AST (etiquetas de Syntax y constructores de AST deben coincidir)
public Program toAST(Tree pt) = implode(#Program, pt);

// Atajo: carga archivo, parsea e implode a AST
public Program load(loc file) = toAST(parseTree(file));
