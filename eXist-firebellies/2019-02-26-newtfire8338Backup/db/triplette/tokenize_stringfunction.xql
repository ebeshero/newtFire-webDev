xquery version "3.1";
collection('/db/shakespeare/plays')/*/tokenize(base-uri(), '/')[last()]
