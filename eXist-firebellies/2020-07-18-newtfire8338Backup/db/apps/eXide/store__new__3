declare default element namespace "http://www.tei-c.org/ns/1.0";
            let $cook := doc('/db/pacific/voyages/cookVoy2Pnum.xml') 
            let $Paras := $cook//p[geo]
            let $geo := $cook//p/geo
            let $countlat := count ($geo[@select="lat"])
            let $countlon := count ($geo[@select="lon"])
            for $p in $Paras  
            where $countlat gt $countlon
            return string-join(('paragraph',$p/@n),': ') 
