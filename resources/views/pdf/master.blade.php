<!DOCTYPE html>
<html>
<head>
    <title>{{$estimate->public_id}} </title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  
    {!!Html::style('/themes/krece/css/style.css')!!}
    
  <style>     
    table.total th,  table.total td, table.total header {
        padding: 3px;
        text-align: left; 
        
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

</body>
</html>