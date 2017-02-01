@extends('layouts.app')

@section('content')


            <div class="view-header">
                <div class="header-icon">
                    <i class="pe page-header-icon pe-7s-add-user"></i>
                </div>
                <div class="header-title">
                    <h3>Registrate aquí GRATIS</h3>
                    <small>
                       A continuación provea todos los datos necesarios para tu registro
                    </small>
                </div>
            </div>

            <div class="panel panel-filled">
                <div class="panel-body">
                    <p>

                    </p>
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
                            {!!Form::text('name',null,['class'=>'form-control','required','placeholder'=>'Nombre de tu negocio'])!!}
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
                            {{ Form::submit('Comenzar',['class'=>'btn btn-accent btn-sm btn-block']) }}                          
                        </div>
                        <div class="form-group">
                            {{ Form::label('text','Ya tienes una cuenta?') }}     
                             <a href="{{ url('/login') }}"><small>Ingresa aquí!</small></a>                        
                         </div>        
                   {!!Form::close()!!}
                </div>
            </div>

     

                   

@endsection
