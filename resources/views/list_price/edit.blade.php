@extends('home')

@section('content')

 <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-4">
                    <h2 >Editar lista de precios</h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="{{route('list_price.index')}}">Inicio</a>
                        </li>                       
                         <li class="active">
                            <strong>Editar</strong>
                        </li>
                    </ol>
                </div>
                
            </div> 
 <div class="row  border-bottom white-bg dashboard-header">
    <div id="list_price">   
        <div class="panel" v-cloak>           
            <div class="panel-body">
                @include('list_price.form')
            </div>
            <div class="panel-footer">
                <div class="clearfix">                 
                    <button class="btn btn-primary" @click="update" :disabled="isProcessing"><i class="fa fa-save"></i>&nbsp;Actualizar</button>                   
                    <a href="{{route('list_price.index')}}" class="btn btn-default">&nbsp;Cancelar</a>
                 </div>
            </div>
        </div>
    </div>
   
</div>

@endsection

@push('scripts')

    {!!Html::script('/js/libraries/axios.min.js')!!}
    {!!Html::script('/js/libraries/moment.min.js')!!}
    {!!Html::script('/js/libraries/accounting.js')!!}
    {!!Html::script('/js/vue-library/vue.min.js')!!}
   {!!Html::script('/js/components/vue-multiselect/multiselect.min.js')!!}
   
    <script type="text/javascript">
      
        Vue.prototype.$http = axios;
        window._form = {!! $listprice->toJson() !!};
    </script>
    
    {!!Html::script('/js/functions/list_price.js')!!}
    
@endpush

