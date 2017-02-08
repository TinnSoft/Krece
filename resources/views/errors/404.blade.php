
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Krece | 404 Error</title>

   {!!Html::style('/themes/krece/css/bootstrap.min.css')!!}
    {!!Html::style('/themes/krece/font-awesome/css/font-awesome.css')!!}
     {!!Html::style('/themes/krece/css/style.css')!!}
     {!!Html::style('/themes/krece/css/animate.css')!!}
    

</head>

<body class="gray-bg">


    <div class="middle-box text-center animated fadeInDown">
        <h1>404</h1>
        <h3 class="font-bold">No pude encontrar la página que buscas</h3>

        <div class="error-desc">
            Lo siento, pero la página que estás intentando acceder no existe. Asegurate que la URL ingresada sea correcta y luego actualiza la página.
            <br/><a href="{{ url('/') }}" class="btn btn-primary m-t">Inicio</a>
        </div>
    </div>

    <!-- Mainly scripts -->
    {!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!}
     {!!Html::script('/themes/krece/js/bootstrap.min.js')!!}  
     

</body>

</html>
