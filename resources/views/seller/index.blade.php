
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
                    <h2>Vendedores</h2>
                    <ol class="breadcrumb">
                        <li class="active">
                            <strong>Inicio</strong>      
                        </li>
                    </ol>
                </div>                
            </div>           

   <div id="seller"  class="row  border-bottom white-bg dashboard-header">
        <div class="panel-body">
       
            @if( $seller->count())  
              <div class="row">            
                <div class="col-lg-12 text-right">
                    <a href="{{route('seller.create')}}" class="btn btn-primary btn-sm pull-right"> 
                    <span class="glyphicon glyphicon-plus"></span>&nbsp;Nuevo vendedor</a>                     
                </div>               
            </div>           
            <div class="hr-line-dashed"></div>      

            <div   class="ibox-content">
               <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover dataTables-data">
                   
                    <thead>
                    <tr>
                         <th>Nombre</th>                        
                        <th>Identificación</th>
                        <th>Observaciones</th>
                        <th>Teléfono de trabajo</th>
                        <th>Teléfono privado</th>
                        <th>Acciones</th>
                    </tr>
                    </thead>
                    <tbody>     
                   
                    @foreach ($seller as $sel)
                        <tr>        
                            <td>{{$sel->name}}</td>
                            <td>{{$sel->dni}}</td>
                            <td>{{$sel->observations}}</td>
                             <td>{{$sel->work_phone}}</td>
                            <td>{{$sel->private_phone}}</td>
                            <td class="text-right">
                                <a>
                                     @if ($sel->isEnabled==1)                                          
                                            <a>
                                            <span
                                                @click="update({{$sel}},0)" 
                                                title="Desactivar" 
                                                class="fa fa-check-square-o">
                                            </span></a>
                                    @else
                                            <a>
                                            <span 
                                                @click="update({{$sel}},1)" 
                                                title="Activar" 
                                                class="fa fa-square-o">
                                            </span>  
                                            </a>          
                                    @endif        
                                </a>
                                
                                    @if ($sel->isEnabled==1)
                                         <a href="{{route('seller.edit', $sel)}}" >
                                            <span id="icon-detail" 
                                                title="Editar cotización" 
                                                class="glyphicon glyphicon-pencil fa-1x green">
                                            </span>
                                        </a>
                                    @else
                                            <span id="icon-detail" 
                                                title="Editar" 
                                                class="glyphicon glyphicon-pencil gray">
                                            </span>       
                                    @endif           

                                
                                <a>
                                    <span id="icon-detail"  
                                        @click="remove({{$sel->id}})" 
                                        title="Eliminar cotización" 
                                        class="glyphicon glyphicon-remove fa-1x red">
                                    </span>
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
                        <th>Identificación</th>
                        <th>Observaciones</th>
                        <th>Teléfono de trabajo</th>
                        <th>Teléfono privado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                </table>
              
                <div class="alert alert-info" role="alert">
                     <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                        <span class="sr-only">Error:</span>
                         Aún no tienes vendedores creados. Por que no empiezas
                        <a href="{{route('seller.create')}}"><strong>creando uno?</a> </strong>
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
  el: '#seller',
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
        axios.put('/seller/' + vm.form.id, vm.form)
          .then(function(response) {
            if(response.data.updated) {              
              window.location = '/seller';
              toastr.success('Estado Actualizado', 'Actualizado', {timeOut: 5000});               
            } else {                                  
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
                axios.delete('/seller/' + val)
                    .then(function(response) {
                        if(response.data.deleted) {
                            swal("Eliminado!", "El registro ha sido eliminado correctamente!!.", "success");
                            window.location = '/seller/';           
                        }
                    })
                    .catch(function(error) {
                         swal("Error!", "El registro no se ha eliminado correctamente, intente de nuevo!!.", "error");
                        console.log(error)
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




