@extends('layouts.app')

@section('content')
  
            <p>Por favor ingresa tus credenciales.</p>
            {!!Form::open(['url'=>'login','method'=>'POST'])!!}
                        <div class="form-group">
                            {!!Form::email('email',null,['class'=>'form-control','required','placeholder'=>'Tu correo'])!!}
                             @if ($errors->has('email'))
                                <span class="help-block">
                                     <strong>{{ $errors->first('email') }}</strong>
                                </span>
                             @endif  
                        </div>

                        <div class="form-group">
                            {!!Form::password('password',['class'=>'form-control','required','placeholder'=>'Tu Contraseña'])!!}
                             @if ($errors->has('password'))
                                 <span class="help-block">
                                    <strong>{{ $errors->first('password') }}</strong>
                                 </span>
                            @endif      
                        </div>

                        <div class="form-group">
                            {{ Form::submit('Entrar',['class'=>'btn btn-primary block full-width m-b']) }}                          
                        </div>
                        <div class="form-group">
                            {{ Form::label('text','Aún no tienes una cuenta?') }}     
                             <a href="{{ url('/register') }}"><small>Crea una aquí!</small></a>                        
                         </div>
                         <div class="form-group">                            
                             <a href="{{ url('/password/reset') }}"><small>Olvidaste tu contraseña?</small></a>    
                         </div>           
                   {!!Form::close()!!}    
                        
@endsection

@section('leftcontent')
    <h2 class="font-bold">Bienvenido</h2>
    <p>
        Krece ayuda a que tengas mas control de tu negocio.
    </p>
    </p>
        Aquí puedes:
        <ul > <br>      
            <li>Crear, enviar e imprimir facturas</li><br>
            <li>Gestionar tu inventario</li><br>
            <li>Notificar a tus clientes acerca del estado de tus facturas</li><br>
            <li>Trabajar en equipo: puedes crear otros usuarios para que trabajen con permisos restringidos</li><br>
            <li>Tener visibilidad de lo que sucede en tu empresa mediante reportes detallados</li><br>
            <li>Gestionar tus cuentas y realizar transacciones en diversas monedas.</li><br>
            <li>Entre otros..</li>
        </ul>
    </p>

@endsection