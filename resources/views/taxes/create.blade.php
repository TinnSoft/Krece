@extends('home')

@section('content')


 <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-4">
                    <h2 >Nuevo Impuesto</h2>
                    <ol class="breadcrumb">                       
                        <li>
                            <a href="{{route('taxes.index')}}">Inicio</a>
                        </li>
                         <li class="active">
                            <strong>Crear</strong>
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
                    <button class="btn btn-primary pull-right" @click="create" :disabled="isProcessing"><i class="fa fa-save"></i>&nbsp;Crear</button>                   
                    <a href="{{route('taxes.index')}}" class="btn btn-default pull-right">&nbsp;Cancelar</a>
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
        window._form = {
            account_id: '',
            public_id: '',
            name: null,
            amount: '',
            description:'',
            type_id: '',
            tax_type: null
        };

    </script>
    {!!Html::script('/js/functions/taxes.js')!!}
   
@endpush
