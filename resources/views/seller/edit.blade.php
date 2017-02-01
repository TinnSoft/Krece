@extends('home')

@section('content')

 <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-4">
                    <h2 >Editar vendedor</h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="{{route('seller.index')}}">Inicio</a>
                        </li>                       
                         <li class="active">
                            <strong>Editar</strong>
                        </li>
                    </ol>
                </div>
                
            </div> 
 <div class="row  border-bottom white-bg dashboard-header">
    <div id="seller">   
        <div class="panel" v-cloak>           
            <div class="panel-body">
                @include('seller.form')
            </div>
            <div class="panel-footer">
                <div class="clearfix">                 
                    <button class="btn btn-primary " @click="update" :disabled="isProcessing"><i class="fa fa-save"></i>&nbsp;Actualizar</button>                   
                    <a href="{{route('seller.index')}}" class="btn btn-default ">&nbsp;Cancelar</a>
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
   
    <script type="text/javascript">
      
        Vue.prototype.$http = axios;
        window._form = {!! $seller->toJson() !!};
    </script>
    {!!Html::script('/js/functions/seller.js')!!}
    
@endpush

