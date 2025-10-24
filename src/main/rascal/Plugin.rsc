module Plugin

import IO;
import ParseTree;
import util::Reflective;
import util::IDEServices;
import util::LanguageServer;
import Syntax;

PathConfig pcfg = getProjectPathConfig(|project://alu|);

Language aluLang = language(pcfg, "ALU", "alu", "Plugin", "contribs");

set[LanguageService] contribs() = {
    parser(start[Program] (str program, loc src) {
        return parse(#start[Program], program, src);
    })
};

void main() {
    registerLanguage(aluLang);
}