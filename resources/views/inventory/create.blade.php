@extends('home',['title' =>  'Inventario'])

@section('content')
  <style>
        .green {color: green;}
        .red {color: red;}
    </style>

 <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-4">
                    <h2 ><span class="fa fa-plus-circle green"></span>   Nuevo producto</h2>
                    <ol class="breadcrumb">                       
                        <li>
                            <a href="{{route('inventory.index')}}">Inicio</a>
                        </li>
                         <li class="active">
                            <strong>Crear</strong>
                        </li>
                    </ol>
                </div>
                
            </div>           

 <div class="row  border-bottom white-bg dashboard-header">
    <div id="inventory">   
        <div class="panel" v-cloak>           
            <div class="panel-body">
                @include('inventory.form')
            </div>
            <div class="panel-footer">
                <div class="clearfix">                 
                    <button class="btn btn-primary pull-right" @click="create" :disabled="isProcessing"><i class="fa fa-save"></i>&nbsp;Crear</button>                   
                    <a href="{{route('inventory.index')}}" class="btn btn-default pull-right">&nbsp;Cancelar</a>
                 </div>
            </div>
        </div>
    </div>
   
</div>
@endsection


@push('scripts')
 
    {!!Html::script('/js/libraries/axios.min.js')!!}
    {!!Html::script('/js/libraries/moment.min.js')!!}
    {!!Html::script('/js/vue-library/vue.min.js')!!}
    {!!Html::script('/js/components/vue-multiselect/multiselect.min.js')!!}
    <script type="text/javascript">
        Vue.prototype.$http = axios;
        window._form = {
            name:'',
            reference:'',
            description:'',
            sale_price:0,
            tax_id:'',
            tax:null,
            list_price_id:'',
            list_price:null,
            category_id:'',
            category:null,
            inv_quantity_initial:'',
            inv_unit_cost:0,
            inv_type_id:'',
            inv_inStock:0
        };

    </script>
   
    {!!Html::script('/js/functions/inventory.js')!!}

      

   
@endpush
