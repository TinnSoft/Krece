@extends('home')

@section('content')

 <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-4">
                    <h2 >Editar Banco</h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="{{route('bank_account.index')}}">Inicio</a>
                        </li>                       
                         <li class="active">
                            <strong>Editar</strong>
                        </li>
                    </ol>
                </div>
                
            </div> 
 <div class="row  border-bottom white-bg dashboard-header">
    <div id="bank_account">   
        <div class="panel" v-cloak>           
            <div class="panel-body">
                @include('bank_account.form')
            </div>
            <div class="panel-footer">
                <div class="clearfix">                 
                    <button class="btn btn-primary pull-right" @click="update" :disabled="isProcessing"><i class="fa fa-save"></i>&nbsp;Actualizar</button>                   
                    <a href="{{route('bank_account.index')}}" class="btn btn-default pull-right">&nbsp;Cancelar</a>
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
        window._form = {!! $account->toJson() !!};
    </script>
    
    {!!Html::script('/js/functions/bank_account.js')!!}
    
@endpush

