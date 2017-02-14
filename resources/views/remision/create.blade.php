@extends('home',['title' =>  'Remision'])

@section('content')


 <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-4">
                    <h2 >Nueva remision</h2>
                    <ol class="breadcrumb">                       
                        <li>
                            <a href="{{route('remision.index')}}">Inicio</a>
                        </li>
                         <li class="active">
                            <strong>Crear</strong>
                        </li>
                    </ol>
                </div>
                
            </div>           

 <div class="row  border-bottom white-bg dashboard-header">
    <div id="remision">   
        <div class="panel" v-cloak>           
            <div class="panel-body">
                @include('remision.form')
            </div>
            <div class="panel-footer">
                <div class="clearfix">                 
                    <button class="btn btn-primary pull-right" @click="create" :disabled="isProcessing"><i class="fa fa-save"></i>&nbsp;Crear</button>                   
                    <a href="{{route('remision.index')}}" class="btn btn-default pull-right">&nbsp;Cancelar</a>
                 </div>
            </div>
        </div>
    </div>
   
</div>
@endsection


@push('scripts')
 
    {!!Html::script('/js/libraries/axios.min.js')!!}
    {!!Html::script('/js/libraries/moment.min.js')!!}
    {!!Html::script('/themes/krece/js/plugins/datapicker/bootstrap-datepicker.js')!!}    
    {!!Html::style('/themes/krece/css/plugins/datapicker/datepicker3.css')!!}
    {!!Html::script('/js/components/datepicker/datepicker-locale.es.min.js')!!}
    {!!Html::script('/js/vue-library/vue.min.js')!!}
    {!!Html::script('/js/components/vue-multiselect/multiselect.min.js')!!}
    {!!Html::script('/js/libraries/accounting.js')!!}
    <script type="text/javascript">
        //Vue.http.headers.common['X-CSRF-TOKEN'] = '{{csrf_token()}}';
        Vue.prototype.$http = axios;
        window._form = {
            public_id: '',
            resolution_id:'',
            customer_id: '',
            documentType_id:'',
            documentType:null,
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
                product:null,
                description:'',
                unit_price: 0,
                discount: 0,
                quantity: 1,
                tax_amount: 0,
                tax_value:null
           }]
        };

    </script>
   
       
   {!!Html::script('/js/components/datepicker/datepicker-vue.js')!!} 
    {!!Html::script('/js/functions/remision.js')!!}
   
@endpush
