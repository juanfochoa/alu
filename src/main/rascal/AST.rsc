module AST

data Program = program(list[Module] modules);

data Module = func(str name, list[Param] params, Block body)
            | dataDecl(str name, TypeDecl typeDecl)
            | stmt(Stmt statement);

data Param = param(str name);

data Block = block(list[Stmt] stmts);

data Stmt = assign(str var, Expr expr)
          | cond(Expr condition, list[Stmt] thenBlock, 
                 list[tuple[Expr, list[Stmt]]] elseifs, 
                 list[Stmt] elseBlock)
          | loop(str iterator, Expr from, Expr to, list[Stmt] body)
          | callS(str name, list[Expr] args);

data Expr = bin(Expr left, Expr right)
          | neg(Expr expr)
          | add(Expr left, Expr right)
          | sub(Expr left, Expr right)
          | mul(Expr left, Expr right)
          | div(Expr left, Expr right)
          | pow(Expr left, Expr right)
          | mdl(Expr left, Expr right)
          | lt(Expr left, Expr right)
          | gt(Expr left, Expr right)
          | le(Expr left, Expr right)
          | ge(Expr left, Expr right)
          | eq(Expr left, Expr right)
          | ne(Expr left, Expr right)
          | and(Expr left, Expr right)
          | or(Expr left, Expr right)
          | id(str name)
          | intLit(int valor)
          | floatLit(real valor)
          | boolLit(bool valor)
          | strLit(str valor)
          | call(str name, list[Expr] args);

data TypeDecl = struct(list[Field] fields)
              | tupleType(list[TypeDecl] types)
              | basic(str typeName);

data Field = field(str name, TypeDecl fieldType);