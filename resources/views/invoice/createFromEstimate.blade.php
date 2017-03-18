@extends('home',['title' =>  'Factura de venta'])

@section('content')

 <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-4">
                    <h2 >Nueva Factura de venta</h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="{{route('invoice.index')}}">Inicio</a>
                        </li>                       
                         <li class="active">
                            <strong>Crear</strong>
                        </li>
                    </ol>
                </div>
                
            </div> 
 <div class="row  border-bottom white-bg dashboard-header">
    <div id="invoice">   
        <div class="panel" v-cloak>           
            <div class="panel-body">
                @include('invoice.form')
            </div>
            <div class="panel-footer">
                <div class="clearfix">                 
                    <button class="btn btn-primary pull-right" @click="create" :disabled="isProcessing"><i class="fa fa-save"></i>&nbsp;Guardar</button>                   
                    <a href="{{route('invoice.index')}}" class="btn btn-default pull-right">&nbsp;Cancelar</a>
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
    {!!Html::script('/themes/krece/js/plugins/datapicker/bootstrap-datepicker.js')!!}    
   {!!Html::style('/themes/krece/css/plugins/datapicker/datepicker3.css')!!}
    {!!Html::script('/js/components/datepicker/datepicker-locale.es.min.js')!!}
    {!!Html::script('/js/vue-library/vue.min.js')!!}
   {!!Html::script('/js/components/vue-multiselect/multiselect.min.js')!!}
   
    <script type="text/javascript">
      
        Vue.prototype.$http = axios;
        window._form = {!! $invoice->toJson() !!};
    </script>
    
   {!!Html::script('/js/components/datepicker/datepicker-vue.js')!!} 
    {!!Html::script('/js/functions/invoice.js')!!}
    
@endpush

