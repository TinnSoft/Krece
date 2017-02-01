@extends('home')

@section('content')

 {!!Html::script('/js/vue-library/vue.min.js')!!}
  {!!Html::script('/js/libraries/axios.min.js')!!}
{!!Html::script('/js/components/vue-multiselect/multiselect.min.js')!!}

    <div class="row wrapper border-bottom white-bg page-heading">
            <div class="col-sm-4">
                <h2>Bancos</h2>
                <ol class="breadcrumb">
                <li>
                    <a href="{{route('bank_account.index')}}">Inicio</a>
                </li>
                <li class="active">
                    <strong>Ver</strong>                            
                </li>
            </ol>
        </div>
                
    </div>           
 
    <div id="bank" class="row wrapper wrapper-content">
      
            <div  class="ibox-title">
                 <div class="ibox-content">
                    <p>
                        <div class="col-lg-6">
                        <label><span>Banco</span></label>
                        <multiselect 
                                v-model="val" 
                                :options="banks" 
                                :multiple="false" 
                                group-values="list" 
                                group-label="name" 
                                placeholder="Banco" 
                                track-by="description" label="description">                                
                        </multiselect>
                        
                        </div>
                        <div class="col-lg-6">
                            <div class="row">   
                                <div class="col-lg-12 text-right">
                                    <div class="btn-group ">
                                            <button data-toggle="dropdown" 
                                                    class="btn btn-info  btn-sm dropdown-toggle ">Mas acciones 
                                                <span class="caret">
                                                </span>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a href="{{route('bank_account.edit', $account)}}">Editar</a></li>
                                                <li><a >Desactivar</a></li>                                               
                                                <li class="divider"></li>
                                                 <li><a >Ver conciliaciones</a></li>
                                            </ul>
                                        </div>
                                        
                                    <a href="{{route('bank_account.create')}}" class="btn btn-primary btn-sm "> 
                                        <span class="glyphicon glyphicon-plus">
                                        </span>&nbsp;Nuevo banco
                                    </a>                     
                                </div>               
                            </div>           
                        </div>
                    </p>
                   
            </div>
            
        </div>
        <div  class="ibox-title">
            <div class="ibox-content">
                 <p>
                        <a class="btn btn-primary  btn-outline btn-sm "> 
                            <span class="fa fa-plus">
                            </span>&nbsp;Agregar dinero
                        </a> 
                        <a class="btn btn-primary  btn-outline btn-sm "> 
                            <span class="fa fa-minus">
                            </span>&nbsp;Retirar dinero
                        </a> 
                        <a class="btn btn-primary  btn-outline btn-sm "> 
                            <span class="fa fa-exchange">
                            </span>&nbsp;Transferir
                        </a> 
                        <a class="btn btn-primary  btn-outline btn-sm"> 
                            <span class="fa fa-gear">
                            </span>&nbsp;Conciliar
                        </a> 

                        
                    </p>
            </div>
        </div>
        <pre><code>@{{$data | json}}</code></pre>
 </div>
          
    

<script>
var app = new Vue({
  el: '#bank',
   components: {
        "Multiselect": VueMultiselect.Multiselect
    },
   data()  {
    return {
        val:[],
     banks: [
        {
          name: 'Bancos',
          list: [
            { id: '1', description: 'bancos 1' },
            { id: '2', description: 'bancos 2' }
          ]
        },
        {
          name: 'Tarjetas de credito',
          list: [
            { id: '3', description: 'Tarjeta de credito 1' }
          ]
        },
        {
          name: 'Efectivo',
          list: [
            { id: '4', description: 'Caja general' }
          ]
        }
      ],
  }},

 
})


</script>

 

@endsection
