
@extends('home',['title' =>  'Factura de venta'])

   

@section('content')
  
    <style>
        .green {color: green;}
        .red {color: red;}
    </style>

 {!!Html::script('/js/vue-library/vue.min.js')!!}
  {!!Html::script('/js/libraries/axios.min.js')!!}
{!!Html::style('/themes/krece/css/plugins/sweetalert/sweetalert.min.css')!!}  
  {!!Html::script('/themes/krece/js/plugins/sweetalert/sweetalert.min.js')!!}  
  {!!Html::script('/js/libraries/moment.min.js')!!}

    <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-4">
                    <h2>Pagos Recibidos</h2>
                  
                    <ol class="breadcrumb">
                        <li class="active">
                            <strong>Inicio</strong>      
                        </li>
                    </ol>
                </div>                
            </div>            
   
      <div id="payment_index"  class="row  border-bottom white-bg dashboard-header">
        <div class="panel-body">
                <div class="ibox-content">   
                    <div class="row">
                            <a href="{{route('payment-in.create')}}" class="btn btn-primary btn-sm pull-right"> 
                            <span class="glyphicon glyphicon-plus"></span>&nbsp;Nuevo Ingreso</a>                     
                    </div>                    
                </div> 
               <div class="row">                             
                    @include('payment-in.index-grid')                           
                </div> 
        </div>   

    </div>


@include('partials.warm_itemNotFound')

<script>

 var paymentApp = new Vue({
  el: '#payment_index',
   data: function()  {
    return {
    idsel:"",
    status:{status_id:null,},
  }},
  methods: {
      printPdf: function(val){
        window.open('/payment-in/'+val+'/pdf', '_blank');
    },
       goShow: function(val){
        window.location = '/payment-in/'+val;
    },
    goEdit: function(val){
        window.location = '/payment-in/'+val+'/edit';
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
                axios.put('/payment_in_update_state/' + item, vm.status)
                .then(function(response) {
                    if(response.data.updated) {   
                         $('#payment-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
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
                axios.delete('/payment-in/' + val)
                    .then(function(response) {
                        if(response.data.deleted) {
                            $('#payment-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
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




