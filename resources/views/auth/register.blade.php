@extends('layouts.app')

@section('content')


           
                <div class="header-title">
                   
                    <label class='text-navy'>
                       Los siguientes datos son necesarios para completar el registro.
                    </label>
                </div>


            <br>
                        {!!Form::open(['url'=>'register','method'=>'POST'])!!}
                        <div class="form-group">
                            {!!Form::email('email',null,['class'=>'form-control','required','placeholder'=>'Digita tu correo'])!!}
                             @if ($errors->has('email'))
                                <span class="help-block">
                                     <strong>{{ $errors->first('email') }}</strong>
                                </span>
                             @endif  
                        </div>

                        <div class="form-group">
                            {!!Form::text('name',null,['class'=>'form-control','required','placeholder'=>'Nombre de tu negocio/empresa'])!!}
                             @if ($errors->has('name'))
                                <span class="help-block">
                                     <strong>{{ $errors->first('name') }}</strong>
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
                            {!!Form::password('password_confirmation',['class'=>'form-control','required','placeholder'=>'Vuelve a escribir tu Contraseña'])!!}
                             @if ($errors->has('password_confirmation'))
                                 <span class="help-block">
                                    <strong>{{ $errors->first('password_confirmation') }}</strong>
                                 </span>
                            @endif      
                        </div>

                        <div class="form-group">
                            {{ Form::submit('Comenzar',['class'=>'btn btn-primary block full-width m-b']) }}                          
                        </div>
                        <div class="form-group">
                            {{ Form::label('text','Ya tienes una cuenta?') }}     
                             <a href="{{ url('/') }}"><small>Ingresa aquí!</small></a>                        
                         </div>        
                   {!!Form::close()!!}
         
     

                   

@endsection

@section('leftcontent')
    <h2 class="font-bold">Regístrate aquí GRATIS</h2>
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