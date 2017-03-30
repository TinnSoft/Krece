@extends('home',['title' =>  'Nota Crédito'])

@section('content')

 <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-4">
                    <h2 >Editar Nota Débito</h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="{{route('debit-note.index')}}">Inicio</a>
                        </li>                       
                         <li class="active">
                            <strong>Editar</strong>
                        </li>
                    </ol>
                </div>
                
            </div> 
 <div class="row  border-bottom white-bg dashboard-header">
    <div id="debitnote">   
        <div class="panel" v-cloak>           
            <div class="panel-body">
                @include('debit-note.form')
            </div>
            <div class="panel-footer">
                <div class="clearfix">                 
                    <button 
                        class="btn btn-primary pull-right ladda-button" 
                        @click="update" 
                        data-style="zoom-in"
                        :disabled="isProcessing"><i class="fa fa-save"></i>&nbsp;Actualizar
                    </button>                   
                    <a href="{{route('debit-note.index')}}" class="btn btn-default pull-right">&nbsp;Cancelar</a>
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
        window._form = {!! $debitnote->toJson() !!};
    </script>
    
   {!!Html::script('/js/components/datepicker/datepicker-vue.js')!!} 
    {!!Html::script('/js/functions/debit-note.js')!!}
    
@endpush

