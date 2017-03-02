<!DOCTYPE html>
<html>
<head>
    <title>{{$id_file}} </title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  
    {!!Html::style('/themes/krece/css/style.css')!!}
    
  <style>     
    table.total th,  table.total td, table.total header {
        padding: 4px;
        text-align: right; 
        
    }
    table.total{
        float: right;
        font-size:70%;
    }
    table.detail th, table.detail td {
        border-bottom: 1px solid #ddd;
        padding: 5px;
        text-align: left;    
    }
    table {border-collapse: collapse;}

</style>

</head>
<body class="white-bg">  
        @yield('content')
         <div class="footer">                         
             <div align="center">             
               <small class="text-muted">{{$document_type}} en el sistema <strong> www.krece.co</strong></small>
             </div>
         </div>
</body>
</html>