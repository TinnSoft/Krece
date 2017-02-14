
@extends('home',['title' =>  'Numeraciones'])

   

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
                <div class="col-sm-6">
                    <h2><span class="fa fa-file-text-o"></span>   Numeracion de documentos</h2>
                    <ol class="breadcrumb">
                        <li class="active">
                            <strong>Inicio</strong>      
                        </li>
                    </ol>
                </div>                
            </div>           

   <div id="resolution_index"  class="row  border-bottom white-bg dashboard-header">

        <div class="panel-body">
            <div class="ibox-content">   
                    @include('resolution.resolution_number')    
                    <div class="row">            
                        <div class="col-lg-12 text-right">
                            <a href="{{route('resolution.create')}}" class="btn btn-primary btn-sm pull-right"> 
                            <span class="fa fa-plus"></span>&nbsp;Nueva numeración</a>                     
                        </div>               
                    </div>                
                    @include('resolution.index-grid')                     
            </div>            
        </div>    
    </div>



@include('partials.warm_itemNotFound')

<script>
var appresolution = new Vue({
  el: '#resolution_index',
   data:function()  {
    return {
        errors:{},
        resolution_number:[],
        status:{isActive:null,},
        form:{
            validate:true
            },
        isProcessing: false,
  }},
  created: function () {  
       var vm = this
      vm.fetchdata();

    },
  methods: {
    fetchdata: function()
      {    
        //carga de los datos del header
        var vm = this
                  axios.get('/getresolutionlist_number')
                      .then(function(response) {  
                          Vue.set(vm.$data, 'resolution_number', response.data);                        
                      })
                      .catch(function(error) {
                          console.log(error)
                      })                  
      },
    update: function()
    {

    },
    //bloquea/desbloquea un producto seleccionado
    updateItemStatus: function(item,status)
    {        
        if (item)
        {
            if (status)
            {
                var vm = this; 
                Vue.set(vm.$data.status, 'isActive', status); 
                axios.put('/update_state/' + item, vm.status)
                .then(function(response) {
                    if(response.data.updated) {   
                         $('#resolution-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
                    }
                    else
                    {
                        toastr.error('No fue posible realizar la actualización del estado, porfavor verifique que no esté marcada como preferida.', 'Error', {timeOut: 5000});
                    }
                })
                .catch(function(error) {     
                    Vue.set(vm.$data, 'errors', error.response.data);                     
                })
            }
        }
    },
    updateNumeration: function()
    {        
       
                var vm = this; 
                 vm.isProcessing=true;         
                axios.put('/update_numeration/1', vm.resolution_number)
                .then(function(response) {
                    if(response.data.updated) {
                         vm.isProcessing=false;
                         toastr.success('Registro actualizado correctamente', 'Actualizado', {timeOut: 5000});    
                    }
                })
                .catch(function(error) { 
                    vm.isProcessing=false;                    
                    console.log(error.response.data);
                    toastr.error('No se ha podido actualizar el registro, intente de nuevo.', 'Error', {timeOut: 5000});
                    Vue.set(vm.$data, 'errors', error.response.data);
                })
       
    },
    goEdit: function(val){
        if (val)
        {
             window.location = '/resolution/'+val+'/edit';
        }
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
                axios.delete('/resolution/' + val)
                    .then(function(response) {
                        if(response.data.deleted) {
                            swal("Eliminado!", "El registro ha sido eliminado correctamente!!.", "success");
                            $('#resolution-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
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




