
@extends('home',['title' =>  'Factura Proveedores'])

   

@section('content')
  
    <style>
        .green {color: green;}
        .red {color: red;}
    </style>

{!!Html::style('/themes/krece/css/plugins/sweetalert/sweetalert.min.css')!!}  
  {!!Html::script('/themes/krece/js/plugins/sweetalert/sweetalert.min.js')!!}  
  {!!Html::script('/js/libraries/moment.min.js')!!}

    <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-7">
                    <h2>Facturas de Proveedores</h2>
                  
                    <ol class="breadcrumb">
                        <li class="active">
                            <strong>Inicio</strong>      
                        </li>
                    </ol>
                </div>                
            </div>            
   
      <div id="bill_index"  class="row  border-bottom white-bg dashboard-header">
        <div class="panel-body">
                <div class="ibox-content">   
                    <div class="row">
                            <a href="{{route('bill.create')}}" class="btn btn-primary btn-sm pull-right"> 
                            <span class="glyphicon glyphicon-plus"></span>&nbsp;Nueva Factura de venta</a>                     
                    </div>                    
                </div>  
               <div class="ibox-content">                                
                    @include('bill.index-grid')                           
                </div>  
        </div>   

    </div>


@include('partials.warm_itemNotFound')

<script>

 var billApp = new Vue({
  el: '#bill_index',
   data: function()  {
    return {
    idsel:"",
    status:{status_id:null,},
  }},
  methods: {
      printPdf: function(val){
        window.open('/bill/'+val+'/pdf', '_blank');
    },
    AddPayment: function(val){
        window.location='/payment-out/create?'+val;     
    },
       goShow: function(val){
        window.location = '/bill/'+val;
    },
    goEdit: function(val){
        window.location = '/bill/'+val+'/edit';
    },
    moment: function (date) {
        return moment(date).fromNow();
    },
    updateItemStatus: function(item,status)
    {  
        if (item)
        {
            if (status)
            {
                var vm = this; 
              
                Vue.set(vm.$data.status, 'status_id', status);                 
                axios.put('/bill_update_state/' + item, vm.status)
                .then(function(response) {
                    if(response.data.updated) {   
                         $('#bill-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
                    }
                })
                .catch(function(error) {  
                    Vue.set(vm.$data, 'errors', error.response.data);
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
                axios.delete('/bill/' + val)
                    .then(function(response) {
                        if(response.data.deleted) {
                            $('#bill-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
                            swal("Eliminado!", "El registro ha sido eliminado correctamente!!.", "success");
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




