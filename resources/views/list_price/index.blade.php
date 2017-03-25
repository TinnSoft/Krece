
@extends('home',['title' =>  'Precios de lista'])

@section('content')
  
    <style>
        .green {color: green;}
        .red {color: red;}
        .gray{color:#D7DBDD;}
    </style>

 {!!Html::script('/js/vue-library/vue.min.js')!!}
  {!!Html::script('/js/libraries/axios.min.js')!!}
{!!Html::style('/themes/krece/css/plugins/sweetalert/sweetalert.min.css')!!}  
  {!!Html::script('/themes/krece/js/plugins/sweetalert/sweetalert.min.js')!!}  

    <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-4">
                    <h2><span class="fa fa-list-alt"></span> Lista de precios</h2>
                    <ol class="breadcrumb">
                        <li class="active">
                            <strong>Inicio</strong>      
                        </li>
                    </ol>
                </div>                
            </div>           
    
     <div id="llistprice"  class="row  border-bottom white-bg dashboard-header">
        <div class="panel-body">
                <div class="ibox-content">   
                    <div class="row">
                            <a href="{{route('list_price.create')}}" class="btn btn-primary btn-sm pull-right"> 
                            <span class="fa fa-plus"></span>&nbsp;Nuevo precio de lista</a>                     
                    </div>                    
                </div> 
               <div class="row">                             
                    @include('list_price.index-grid')                           
                </div> 
        </div>   

    </div>



@include('partials.warm_itemNotFound')

<script>
var appListPrice = new Vue({
  el: '#listprice',
  data()  {
    return {
    isProcessing: false,
    form: {},
    errors: {}
  }},
  methods: {
       goEdit: function(val){
        window.location = '/list_price/'+val+'/edit';
    },
    updateItemStatus: function(item, state){
   
        if (item)
        {
            if (state)
            {
                var vm = this; 
              
                Vue.set(vm.$data.form, 'isEnabled', state);                 
                axios.put('/listprice_update_state/' + item, vm.form)
                .then(function(response) {
                    if(response.data.updated) {   
                         $('#listprice-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
                         toastr.success('Estado Actualizado', 'Actualizado', {timeOut: 5000}); 
                    }
                     else {
                                            
                    vm.isProcessing = false;
                    toastr.warning('No se ha podido actualizar el registro, intente de nuevo.', 'Error', {timeOut: 5000});
                    }
                })
                .catch(function(error) {  
                    Vue.set(vm.$data, 'errors', error.response.data);
                    toastr.error('No se ha podido actualizar el registro, intente de nuevo.', 'Error', {timeOut: 5000});
                })
               
            }
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
                axios.delete('/list_price/' + val)
                    .then(function(response) {
                        if(response.data.deleted) {
                            swal("Eliminado!", "El registro ha sido eliminado correctamente!!.", "success");
                             $('#listprice-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');                             
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




