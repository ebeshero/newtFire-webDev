xquery version "3.1";
collection('/db/shakespeare/plays')/*/TITLE[.//(count(distinct-values(.//SPEAKER))gt 40)]