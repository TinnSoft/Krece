@extends('home',['title' =>  'Factura de venta'])

@section('content')


 <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-4">
                    <h2 >Nuevo gasto</h2>
                    <ol class="breadcrumb">                       
                        <li>
                            <a href="{{route('payment-out.index')}}">Inicio</a>
                        </li>
                         <li class="active">
                            <strong>Crear</strong>
                        </li>
                    </ol>
                </div>
                
            </div>           

 <div class="row  border-bottom white-bg dashboard-header">
    <div id="payment-out">   
        <div class="panel" v-cloak>           
            <div class="panel-body">
                @include('payment-out.form')
            </div>
            <div class="panel-footer">
                <div class="clearfix">                 
                    <button 
                        class="btn btn-primary pull-right ladda-button" 
                        @click="create" 
                        data-style="zoom-in"
                        :disabled="isProcessing"><i class="fa fa-save"></i>&nbsp;Crear
                    </button>                   
                    <a href="{{route('payment-out.index')}}" class="btn btn-default pull-right">&nbsp;Cancelar</a>
                 </div>
            </div>
        </div>
    </div>
   
</div>
@endsection


@push('scripts')
 

    {!!Html::script('/js/libraries/moment.min.js')!!}
    {!!Html::script('/themes/krece/js/plugins/datapicker/bootstrap-datepicker.js')!!}    
    {!!Html::style('/themes/krece/css/plugins/datapicker/datepicker3.css')!!}
    {!!Html::script('/js/components/datepicker/datepicker-locale.es.min.js')!!}
    {!!Html::script('/js/components/vue-multiselect/multiselect.min.js')!!}
    {!!Html::script('/js/libraries/accounting.js')!!}
    <script type="text/javascript">
        //Vue.http.headers.common['X-CSRF-TOKEN'] = '{{csrf_token()}}';
        Vue.prototype.$http = axios;
        window._kindOfProcess ="create";
        window._form = {
            public_id: '',
            resolution_id:'',
            resolution_number:'',
            isInvoice:null,
            customer_id: '',
            payment_method_id:'',
            payment_method:null,
            contact: null,
            notes: '',
            observations:'',
            date: '',
            bank_account_id:'', 
            bank_account:null,
            currency_code:'',
            currency:null,              
            pending_payment_out:[]
        };

    </script>
   
       
   {!!Html::script('/js/components/datepicker/datepicker-vue.js')!!} 
    {!!Html::script('/js/functions/payment-out.js')!!}
   
@endpush
