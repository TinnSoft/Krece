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
                    <button 
                        class="btn btn-primary pull-right ladda-button" 
                        @click="create" 
                        data-style="zoom-in"
                        :disabled="isProcessing"><i class="fa fa-save"></i>&nbsp;Crear
                    </button>                   
                    <a href="{{route('invoice.index')}}" class="btn btn-default pull-right">&nbsp;Cancelar</a>
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

        Vue.prototype.$http = axios;
        window._form = {
            public_id: '',
            resolution_id:'',
            resolution_number:'',
            customer_id: '',
            payment_terms_id:'',
            payment_terms:null,
            prefix:'',
            contact: null,
            notes: '',
            observations:'',
            date: '',
            due_date: '', 
            seller_id:'',
            seller:null,
            list_price_id:'', 
            list_price:null,
            currency_code:'',
            currency:null,
            sub_total:'',
            total_discounts:'',
            total_taxes:'',
            total:'',           
            detail: [{
                product_id: '',
                tax_id:'',
                product:null,
                description:'',
                unit_price: 0,
                reference:'',
                discount: 0,
                quantity: 1,
                tax_amount: 0,
                tax_value:null
           }]
        };

    </script>
   
       
   {!!Html::script('/js/components/datepicker/datepicker-vue.js')!!} 
    {!!Html::script('/js/functions/invoice.js')!!}
   
@endpush
