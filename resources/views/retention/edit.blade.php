@extends('home')

@section('content')

 <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-4">
                    <h2 >Actualización de Retenciones</h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="{{route('retention.index')}}">Inicio</a>
                        </li>                       
                         <li class="active">
                            <strong>Editar</strong>
                        </li>
                    </ol>
                </div>
                
            </div> 
 <div class="row  border-bottom white-bg dashboard-header">
    <div id="retention">   
        <div class="panel" v-cloak>           
            <div class="panel-body">
              @include('retention.form')
            </div>
            <div class="panel-footer">
                <div class="clearfix">                 
                    <button class="btn btn-primary pull-right" @click="update" :disabled="isProcessing"><i class="fa fa-save"></i>&nbsp;Actualizar</button>                   
                    <a href="{{route('retention.index')}}" class="btn btn-default pull-right">&nbsp;Cancelar</a>
                 </div>
            </div>
        </div>
    </div>
   
</div>

@endsection

@push('scripts')

    {!!Html::script('/js/libraries/axios.min.js')!!}
    {!!Html::script('/js/vue-library/vue.min.js')!!}
   {!!Html::script('/js/components/vue-multiselect/multiselect.min.js')!!}
   
    <script type="text/javascript">      
        Vue.prototype.$http = axios;
       window._form = {!! $retentionlist->toJson() !!};
    </script>
    {!!Html::script('/js/functions/retention.js')!!}
    
@endpush

