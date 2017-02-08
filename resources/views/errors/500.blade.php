
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Krece | 500 Error</title>

   {!!Html::style('/themes/krece/css/bootstrap.min.css')!!}
    {!!Html::style('/themes/krece/font-awesome/css/font-awesome.css')!!}
     {!!Html::style('/themes/krece/css/style.css')!!}
     {!!Html::style('/themes/krece/css/animate.css')!!}

</head>

<body class="gray-bg">


    <div class="middle-box text-center animated fadeInDown">
        <h1>500</h1>
        <h3 class="font-bold">Un error interno en el servidor ha ocurrido</h3>

        <div class="error-desc">
            No fue posible completar la operación debido a que el servidor encontró algo inseperado. Lo sentimos.
            Intenta volver al inicio y ejecutar nuevamente el proceso.
           <br/><a href="{{ url('/') }}" class="btn btn-primary m-t">Inicio</a>
        </div>
    </div>

    <!-- Mainly scripts -->
     {!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!}
     {!!Html::script('/themes/krece/js/bootstrap.min.js')!!}  

</body>

</html>
