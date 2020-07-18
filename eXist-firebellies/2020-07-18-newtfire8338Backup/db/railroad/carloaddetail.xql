xquery version "3.1";
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>The Woodbury Clay Co Project.</title>
      <meta name="author" content="C. R. Chinoy">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <link rel="stylesheet" type="text/css" href="../css/index.css">
   </head>
   <body><!--#include virtual="/header.shtml"-->
      <div id="content">
         <h1>Bill Detail</h1>
         <table class="center">
            <thead>
               <tr>
                  <th>Date</th>
                  <th>Car</th>
                  <th>Class</th>
                  <th>Shipper</th>
                  <th>Consignee</th>
                  <th>Freight</th>
                  <th>Details</th>
               </tr>
            </thead>
            <tbody>{
                
                
                let $carloadtable := doc('/db/railroad/carloadtable.xml')
                let $companytable := doc('/db/railroad/companytable.xml')
                let $classtable := doc('/db/railroad/carclasstable.xml')
                let $carloads := $carloadtable//carload
                for $carload in $carloads
                let $class := $classtable//class[@classid = $carload/@classid]
                let $shipper := $companytable//plant[@plantid = $carload/@shipperid]
                let $consignee := $companytable//plant[@plantid = $carload/@consigneeid]
                where 1=1
                order by $carload/parent::bill/date/text()
                return
                <tr>
                <td>{$carload/parent::bill/date/text()}</td>
                <td>{concat($carload/road/text(),' ',$carload/carnum/text())}</td>
                <td>{$class/classname/text()}</td>
                <td>{concat($shipper/parent::company/name/text(),' ',$shipper/plantname/text())}</td>
                <td>{concat($consignee/parent::company/name/text(),' ',$consignee/plantname/text())}</td>
                <td>{$carload/lading/text()}</td>
                <td><a href="/carloadtable/bill_{$carload/parent::bill/@billid}.html">View Bill</a></td>
                </tr>
            }</tbody>
         </table>
      </div>
      <!--#include file="footer.shtml"--></body>
</html>