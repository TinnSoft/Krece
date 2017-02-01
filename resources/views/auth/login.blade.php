@extends('layouts.app')

@section('content')
                
            <div class="view-header">
                <div class="header-icon">
                    <i class="pe page-header-icon pe-7s-unlock"></i>
                </div>
                <div class="header-title">
                 <h3>Bienvenido a Krece</h3>  
                       <small>
                        Por favor ingrese sus credenciales
                    </small>
                </div>
            </div>            

            <div class="panel panel-filled">
                <div class="panel-body">
                   
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
                            {{ Form::submit('Entrar',['class'=>'btn btn-accent btn-sm btn-block']) }}                          
                        </div>
                        <div class="form-group">
                            {{ Form::label('text','Aún no tienes una cuenta?') }}     
                             <a href="{{ url('/register') }}"><small>Crea una aquí!</small></a>                        
                         </div>
                         <div class="form-group">                            
                             <a href="{{ url('/password/reset') }}"><small>Olvidaste tu contraseña?</small></a>    
                         </div>           
                   {!!Form::close()!!}
                    <!--
                    <form action="{{ url('/login') }}" id="loginForm" role="form" method="POST">
                       {{ csrf_field() }}
                       <div class="form-group{{ $errors->has('email') ? ' has-error' : '' }}">                          
                            <input type="email" placeholder="Tu correo" title="Porfavor ingrese su correo" required="" value="" name="email" id="email" class="form-control">
                             @if ($errors->has('email'))
                                <span class="help-block">
                                     <strong>{{ $errors->first('email') }}</strong>
                                </span>
                             @endif                                                      
                        </div>  
                        <div class="form-group{{ $errors->has('password') ? ' has-error' : '' }}">  
                            <input type="password" title="Por favor ingrese su contraseña" placeholder="Tu Contraseña" required="" value="" name="password" id="password" class="form-control">
                            @if ($errors->has('password'))
                                 <span class="help-block">
                                    <strong>{{ $errors->first('password') }}</strong>
                                 </span>
                            @endif                               
                        </div>                                                
                        <div>
                            <button class="btn btn-accent">Entrar</button>
                            <a class="btn btn-default" href="{{ url('/register') }}">Crear cuenta</a>
                             <a href="{{ url('/password/reset') }}"><small>Olvidaste tu contraseña?</small></a>     
                        </div>                        
                    </form>
                    -->
                </div>
            </div>
                                       
@endsection