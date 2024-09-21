grammar Guava;

fragment OpSymbol
: 'while'
| 'for'
| 'if'
| 'else'
| 'match'
| '*'
| '/'
| '\\'
| ':'
| '.'
| '<'
| '>'
| '='
| '+'
| '-'
| '!'
| '|'
;

Op: OpSymbol+;
OpRefPrefix: 'op';

Comma: ',';
Semi: ';';

OpenBrack: '{';
CloseBrack: '}';

OpenBrace: '[';
CloseBrace: ']';

OpenParen: '(';
CloseParen: ')';

CompilerId: '$' Id;
Let: 'let';
CompilerTag: '@' Id;

Id: [A-Za-z_][A-Za-z_0-9]*;
Int: [0-9]+;
Double: Int '.' Int;
String
: [A-Za-z]?'"' .*? '"'
| '\'' .*? '\''
;

Nl: [\n\r]+ | EOF;
Space: [ \t] -> skip;

code: nl* (line nl)* (line nl?)?;

line: statement | expr;

nl: (Nl | Semi)+;

identifier
: Id
| identifier Nl* '<' Nl* (expr Nl* Comma Nl*)* expr '>' Nl*
;

compilerTag: CompilerTag .*? Nl;

statement
: /*tag*/(compilerTag Nl*)* /*type*/identifier+ /*name*/identifier Nl* /*args*/encapsExpr?  /*body*/(Nl? expr | Nl* encapsScope) #decltype
| /*tag*/compilerTag* /*type*/identifier+ /*name*/OpRefPrefix Op Nl* /*args*/encapsExpr?  /*body*/(Nl? expr | Nl* encapsScope) #declop
| Let /*options*/Id* /*init*/expr #declvar
| encapsScope #encapsScopeStatement
;

//expr
//: Op expr #prefix
////| expr Op #suffix
//| expr Op expr #binary
//| OpenParen Nl* expr Nl* CloseParen #parenExpr
////| expr Nl* (encapsExpr|encapsScope) #exprEncapsExpr
//| atom exprTail #tailExpr
//| atom #atomexpr
//;

expr
: (Op* atom Op* Op+)* Op* atom exprTail*
;

exprTail
: Op
| Nl* (encapsExpr|encapsScope)
;

encapsScope
: OpenBrack Nl* line? Nl* CloseBrack
| OpenBrack Nl* (line nl)+ line Nl* CloseBrack
| OpenBrack Nl* (line Nl* Comma Nl*)+ line Nl* CloseBrack
;

encapsExpr
: OpenBrack Nl* tuples Nl* CloseBrack
| OpenBrace Nl* tuples Nl* CloseBrace
| OpenParen Nl* tuples Nl* CloseParen
;

tuples: ((tuple nl)* tuple Nl*)?;
tuple: (expr Nl* Comma Nl*)* expr Nl*;

atom
: identifier
| CompilerId
| Int
| Double
| String
| OpenParen Nl* expr Nl* CloseParen
;