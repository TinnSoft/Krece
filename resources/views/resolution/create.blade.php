@extends('home',['title' =>  'Numeraciones'])

@section('content')
  <style>
        .green {color: green;}
        .red {color: red;}
    </style>

 <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-6">
                    <h2 ><span class="fa fa-plus-circle green"></span>   Nueva numeración para factura de venta</h2>
                    <ol class="breadcrumb">                       
                        <li>
                            <a href="{{route('resolution.index')}}">Inicio</a>
                        </li>
                         <li class="active">
                            <strong>Crear</strong>
                        </li>
                    </ol>
                </div>
                
            </div>           

 <div class="row  border-bottom white-bg dashboard-header">
    <div id="resolution">   
        <div class="panel" v-cloak>           
            <div class="panel-body">
                @include('resolution.form')
            </div>
            <div class="panel-footer">
                <div class="clearfix">                 
                    <button class="btn btn-primary pull-right" @click="create" :disabled="isProcessing"><i class="fa fa-save"></i>&nbsp;Crear</button>                   
                    <a href="{{route('resolution.index')}}" class="btn btn-default pull-right">&nbsp;Cancelar</a>
                 </div>
            </div>
        </div>
    </div>
   
</div>
@endsection


@push('scripts')
 
    {!!Html::script('/js/libraries/axios.min.js')!!}
    {!!Html::script('/js/vue-library/vue.min.js')!!}
    <script type="text/javascript">
        Vue.prototype.$http = axios;
        window._form = {
            name:'',
            initial_number:'',
            final_number:'',
            prefix:'',
            invoice_text:'',
            isDefault:0,
            auto_increment:true
        };

    </script>
   
    {!!Html::script('/js/functions/resolution.js')!!}

      

   
@endpush
