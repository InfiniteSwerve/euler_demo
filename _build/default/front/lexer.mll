(* Header: Anything in this section will be copied to the top of the lexer.ml file generated by Ocamllex *)
{
    open Parser
}

let white = [' ' '\t']+
let digit = ['0'-'9']
let int = '-'? digit+
let letter = ['a'-'z' 'A'-'Z']
let var = letter+

(* Rule and parse are keywords to pattern match using regex 
    i.e. "match <string> and return { action (might be token) }" 
    pieces of larger sets are matched first, otherwise supersets 
    like the generic var would match way too many things *)

rule read = 
    parse
    | white { read lexbuf }
    | "true" { TRUE }
    | "false" { FALSE }
    | "fun" { FUN }
    | "->" { RARROW }
    | "+" { ADD }
    | "-" { SUB }
    | "*" { MULT }
    | "/" { DIV }
    | "&&" { AND }
    | "||" { OR }
    | "let" { LET }
    | "=" { EQUAL }
    | "in" { IN }
    | "(" { LPAREN }
    | ")" { RPAREN }
    | var { VAR (Lexing.lexeme lexbuf) }
    | int { INT (int_of_string (Lexing.lexeme lexbuf)) }
    | eof { EOF }