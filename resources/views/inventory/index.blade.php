
@extends('home',['title' =>  'Inventario'])

   

@section('content')
  
    <style>
        .green {color: green;}
        .red {color: red;}
    </style>

 {!!Html::script('/js/vue-library/vue.min.js')!!}
  {!!Html::script('/js/libraries/axios.min.js')!!}
{!!Html::style('/themes/krece/css/plugins/sweetalert/sweetalert.min.css')!!}  
  {!!Html::script('/themes/krece/js/plugins/sweetalert/sweetalert.min.js')!!}  

    <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-4">
                    <h2><span class="fa fa-cubes"></span>  Gestión de inventario</h2>
                    <ol class="breadcrumb">
                        <li class="active">
                            <strong>Inicio</strong>      
                        </li>
                    </ol>
                </div>                
            </div>           

   <div id="inventory_index"  class="row  border-bottom white-bg dashboard-header">
        <div class="panel-body">
              <div class="row">            
                <div class="col-lg-12 text-right">
                    <a href="{{route('inventory.create')}}" class="btn btn-primary btn-sm pull-right"> 
                    <span class="glyphicon glyphicon-plus"></span>&nbsp;Crear nuevo ítem de venta</a>                     
                </div>               
            </div>         
            
            <div class="ibox-content">                                
                    @include('inventory.index-grid')                     
            </div>            
        </div>      
    </div>



@include('partials.warm_itemNotFound')

<script>
var app = new Vue({
  el: '#inventory_index',
   data:function()  {
    return {
    errors:{},
    form:{
        isActive:null,
        validate:true
    }
  }},
  methods: {
      
    //bloquea/desbloquea un producto seleccionado
    updateItemStatus: function(item,status)
    {        
        if (item)
        {
            if (status)
            {
                var vm = this; 
                Vue.set(vm.$data.form, 'isActive', status);
               
                vm.isProcessing = true;
                axios.put('/inventory/' + item, vm.form)
                .then(function(response) {
                    if(response.data.updated) {           
                         $('#inventory-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
                    }
                })
                .catch(function(error) {
                    vm.isProcessing = false;
                    Vue.set(vm.$data, 'errors', error.response.data);
                })
            }
        }
    },
    goShow: function(val){
        window.location = '/inventory/'+val;
    },
    goEdit: function(val){
        window.location = '/inventory/'+val+'/edit';
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
                axios.delete('/inventory/' + val)
                    .then(function(response) {
                        if(response.data.deleted) {
                            swal("Eliminado!", "El registro ha sido eliminado correctamente!!.", "success");
                            $('#inventory-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
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




