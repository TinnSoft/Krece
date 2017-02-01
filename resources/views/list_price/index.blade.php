
@extends('home')

   

@section('content')
  
    <style>
        .green {color: green;}
        .red {color: red;}
        .gray{color:#D7DBDD;}
    </style>

 {!!Html::script('/js/vue-library/vue.min.js')!!}
  {!!Html::script('/js/libraries/axios.min.js')!!}
{!!Html::script('/js/functions/DataTable_initializer.js')!!}
{!!Html::style('/themes/krece/css/plugins/sweetalert/sweetalert.min.css')!!}  
  {!!Html::script('/themes/krece/js/plugins/sweetalert/sweetalert.min.js')!!}  

    <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-4">
                    <h2>Lista de precios</h2>
                    <ol class="breadcrumb">
                        <li class="active">
                            <strong>Inicio</strong>      
                        </li>
                    </ol>
                </div>                
            </div>           

   <div  class="row  border-bottom white-bg dashboard-header">
        <div class="panel-body">
       
            @if( $listprice->count())  
              <div class="row">            
                <div class="col-lg-12 text-right">
                    <a href="{{route('list_price.create')}}" class="btn btn-primary btn-sm btn-rounded pull-right"> 
                    <span class="glyphicon glyphicon-plus"></span>&nbsp;Nueva lista de precios</a>                     
                </div>               
            </div>           
            <div class="hr-line-dashed"></div>      

            <div id="listprice"  class="ibox-content">
               <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover dataTables-data">
                   
                    <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Es Principal?</th>
                         <th>Tipo</th>
                         <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                    </thead>
                    <tbody>     
                   
                    @foreach ($listprice as $lprice)
                        <tr>                        
                            <td>{{$lprice->name}}</td>                          
                            <td>
                                @if ($lprice->isDefault==1)
                                    Si                                
                                @else
                                    No
                                @endif
                            </td>
                            <td>
                                 @if ($lprice->type_id==1)
                                    {{$lprice->listprice_type->type .' ('.$lprice->value.'%)'}}
                                 @else
                                    {{$lprice->listprice_type->type}}
                                 @endif
                                
                            </td>  
                            <td>
                                @if ($lprice->isEnabled==1)
                                    <p><span class="label label-primary">Activo</span></p>                     
                                @else
                                    <p><span class="label label-warning">Inactivo</span></p>
                                @endif
                            </td>
                            <td class="text-right">
                                <a>
                                 @if ($lprice->isEnabled==1)                                          
                                            <a>
                                            <span
                                                @click="update({{$lprice}},0)" 
                                                title="Desactivar" 
                                                class="fa fa-check-square-o">
                                            </span></a>
                                    @else
                                            <a>
                                            <span 
                                                @click="update({{$lprice}},1)" 
                                                title="Activar" 
                                                class="fa fa-square-o">
                                            </span>  
                                            </a>          
                                    @endif        

                                    @if ($lprice->isEnabled==1)
                                          <a href="{{route('list_price.edit', $lprice)}}" >
                                            <span id="icon-detail" 
                                                title="Editar" 
                                                class="glyphicon glyphicon-pencil green">
                                            </span>
                                        </a>
                                    @else
                                            <span id="icon-detail" 
                                                title="Editar" 
                                                class="glyphicon glyphicon-pencil gray">
                                            </span>       
                                    @endif                                   
                               
                                     @if ($lprice->isDefault!=1)                                         
                                        <a>
                                        <span id="icon-detail"  
                                            @click="remove({{$lprice->id}})" 
                                            title="Eliminar" 
                                            class="glyphicon glyphicon-remove red">
                                        </span>
                                        </a>
                                    @else
                                          <span id="icon-detail"
                                            title="Eliminar" 
                                            class="glyphicon glyphicon-remove gray">
                                        </span>
                                    @endif
                                </a>
                            </td>
                        </tr>
                    @endforeach
                    </tbody>
                </table>
            </div>
            
            @else
                  <table class="table table-striped table-hover dataTables-data">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Es Principal?</th>
                        <th>Tipo</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                </table>
              
                <div class="alert alert-info" role="alert">
                     <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                        <span class="sr-only">Error:</span>
                         Aún no tienes listas de precio creadas. Por que no empiezas
                        <a href="{{route('list_price.create')}}"><strong>creando una?</a> </strong>
                </div>                   
            @endif
        </div>       
      

    </div>


<script>
  @if(Session::has('message'))
     var type = "{{ Session::get('alert-type', 'info') }}";
    setTimeout(function() {
                toastr.options = {
                    closeButton: true,
                    progressBar: true,
                    showMethod: 'slideDown',
                    timeOut: 4000
                };
               
            switch(type){
                case 'info':
                    toastr.info("{{ Session::get('message') }}");
                    break;
                
                case 'warning':
                    toastr.warning("{{ Session::get('message') }}");
                    break;

                case 'success':
                    toastr.success("{{ Session::get('message') }}");
                    break;

                case 'error':
                    toastr.error("{{ Session::get('message') }}");
                    break;
            }
        }, 1300);


  @endif
</script>

<script>
var app = new Vue({
  el: '#listprice',
  data()  {
    return {
    isProcessing: false,
    form: {},
    errors: {}
  }},
  methods: {
    update: function(val1, state){
        var vm = this; 
        vm.form=val1;
        vm.form.isEnabled=state;
        vm.isProcessing = true;
        axios.put('/list_price/' + vm.form.id, vm.form)
          .then(function(response) {
            if(response.data.updated) {              
              window.location = '/list_price';
              toastr.success('Estado Actualizado', 'Actualizado', {timeOut: 5000});               
            } else {
                //if (state==0){ this.for.isEnabled=1}else{this.for.isEnabled=0};                                
              vm.isProcessing = false;
              toastr.warning('No se ha podido actualizar el registro, intente de nuevo.', 'Error', {timeOut: 5000});
            }
          })
          .catch(function(error) {
            vm.isProcessing = false;           
            Vue.set(vm.$data, 'errors', error.response.data);
            toastr.error('No se ha podido actualizar el registro, intente de nuevo.', 'Error', {timeOut: 5000});
          })
    },
    remove:function(val) {
      let self = this;
      swal({
        title: "Estas seguro?",
        text: "Una vez eliminado este registro no se podrá recuperar",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        confirmButtonText: 'Si, eliminar',
        cancelButtonText: 'Cancelar',
        closeOnConfirm: false
      }, function(isConfirm) {
        if (isConfirm) {
             var vm = this
                axios.delete('/list_price/' + val)
                    .then(function(response) {
                        if(response.data.deleted) {
                            swal("Eliminado!", "El registro ha sido eliminado correctamente!!.", "success");
                             window.location = '/list_price/';             
                        }
                    })
                    .catch(function(error) {
                         swal("Error!", "El registro no se ha eliminado correctamente, intente de nuevo!!.", "error");
                    })
          
        } else {
          swal("Cancelado", "Cancelado :)", "error");
        }
      }.bind(this)); 
    }
  }
})


</script>

@endsection




