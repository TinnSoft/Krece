@extends('layouts.app')

<!-- Main Content -->
@section('content')

                    @if (session('status'))
                        <div class="alert alert-success">
                            {{ session('status') }}
                        </div>
                    @endif

                    <form class="form-horizontal" role="form" method="POST" action="{{ url('/password/email') }}">
                        {{ csrf_field() }}

                        <div class="form-group{{ $errors->has('email') ? ' has-error' : '' }}">
                           

                            <div class="col-md-8">
                                <input id="email" type="email" 
                                class="form-control"  placeholder='Mi email'
                                name="email" value="{{ old('email') }}" required>

                                @if ($errors->has('email'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('email') }}</strong>
                                    </span>
                                @endif
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-6 ">
                                <button type="submit" class="btn btn-primary">
                                   Enviar recordatorio
                                </button>
                                 <div><a href="{{ url('/') }}"><small>Regresar</small></a></div>
                            </div>
                        
                         </div> 
                    </form>
               
@endsection
