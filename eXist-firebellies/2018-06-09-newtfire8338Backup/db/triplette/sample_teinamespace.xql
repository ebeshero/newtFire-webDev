xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
      let $pacific := collection('/db/pacific/voyages')/*
      let $GeorgFile := $pacific[.//author[contains(., 'Georg')]]//titleStmt/title
      return $GeorgFile
            
