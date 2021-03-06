@extends('home',['title' =>  'Impuestos'])

@section('content')

 <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-4">
                    <h2 >Actualización de impuesto</h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="{{route('taxes.index')}}">Inicio</a>
                        </li>                       
                         <li class="active">
                            <strong>Editar</strong>
                        </li>
                    </ol>
                </div>
                
            </div> 
 <div class="row  border-bottom white-bg dashboard-header">
    <div id="taxes">   
        <div class="panel" v-cloak>           
            <div class="panel-body">
              @include('taxes.form')
            </div>
            <div class="panel-footer">
                <div class="clearfix">                 
                    <button class="btn btn-primary pull-right" @click="update" :disabled="isProcessing"><i class="fa fa-save"></i>&nbsp;Actualizar</button>                   
                    <a href="{{route('taxes.index')}}" class="btn btn-default pull-right">&nbsp;Cancelar</a>
                 </div>
            </div>
        </div>
    </div>
   
</div>

@endsection

@push('scripts')

   {!!Html::script('/js/components/vue-multiselect/multiselect.min.js')!!}
   
    <script type="text/javascript">      
        Vue.prototype.$http = axios;
       window._form = {!! $taxlist->toJson() !!};
    </script>
    {!!Html::script('/js/functions/taxes.js')!!}
    
@endpush

