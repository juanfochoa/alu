module AST

data Program = program(list[Module] modules);

data Module = func(str name, list[Param] params, Block body)
            | dataDecl(str name, TypeDecl typeDecl)
            | stmt(Stmt statement);

data Param = param(str name);

data Block = block(list[Stmt] stmts);

data Stmt = assign(str var, Expr expr)
          | cond(Expr condition, Block thenBlock, list[Block] elseBlock)
          | loop(str iterator, Expr range, Block body)
          | callS(str name, list[Expr] args);

data Expr = bin(Expr left, Op op, Expr right)
          | neg(Expr expr)
          | id(str name)
          | intLit(int valor)
          | floatLit(real valor)
          | boolLit(bool valor)
          | strLit(str valor)
          | call(str name, list[Expr] args);

data Op = add() | sub() | mul() | div()
        | pow() | mdl()
        | lt() | gt() | le() | ge()
        | eq() | ne()
        | and() | or();

data TypeDecl = struct(list[Field] fields)
              | tupleType(list[TypeDecl] types)
              | basic(str typeName);

data Field = field(str name, TypeDecl fieldType);