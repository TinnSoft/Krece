
@extends('home',['title' =>  'Términos de pago'])



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
                    <h2>Términos de Pago</h2>
                    <ol class="breadcrumb">
                        <li class="active">
                            <strong>Inicio</strong>      
                        </li>
                    </ol>
                </div>                
            </div>           

<div id="paymentterms"  class="row  border-bottom white-bg dashboard-header">
        <div class="panel-body">
                <div class="ibox-content">   
                    <div class="row">
                            <a href="{{route('payterms.create')}}" class="btn btn-primary btn-sm pull-right"> 
                            <span class="fa fa-plus"></span>&nbsp;Nuevo término de pago</a>                     
                    </div>                    
                </div>  
               <div class="row">                                
                    @include('payterms.index-grid')                           
                </div>  
        </div>   
    </div>

@include('partials.warm_itemNotFound')

<script>
Vue.config.devtools = true;
Vue.config.debug = true;

var appPaymentTerm = new Vue({
  el: '#paymentterms',
   data()  {
    return {
    errors:{}
  }},
  methods: {
       goEdit: function(val){
        window.location = '/payterms/'+val+'/edit';
    },
    remove:function(val) {
      let self = this;
      swal({
        title: "Estas seguro?",
        text: "Una vez eliminado este registro no se podrá recuperar",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#148138",
        confirmButtonText: 'Si, eliminar',
        cancelButtonText: 'Cancelar',
        closeOnConfirm: false
      }, function(isConfirm) {
        if (isConfirm) {
             var vm = this
                axios.delete('/payterms/'+val)
                    .then(function(response) {
                        if(response.data.deleted) {
                            swal("Eliminado!", "El registro ha sido eliminado correctamente!!.", "success");
                            $('#paymentterms-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');                           
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




