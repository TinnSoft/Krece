
@extends('home',['title' =>  'Impuestos'])



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
                    <h2>Lista de Impuestos</h2>
                    <ol class="breadcrumb">
                        <li class="active">
                            <strong>Inicio</strong>      
                        </li>
                    </ol>
                </div>                
            </div>           

    <div id="taxes_index"  class="row  border-bottom white-bg dashboard-header">
        <div class="panel-body">
                <div class="ibox-content">   
                    <div class="row">
                            <a href="{{route('taxes.create')}}" class="btn btn-primary btn-sm pull-right"> 
                            <span class="fa fa-plus"></span>&nbsp;Nuevo Impuesto</a>                     
                    </div>                    
                </div>  
               <div class="row">                                
                    @include('taxes.index-grid')                           
                </div>  
        </div>   
    </div>


@include('partials.warm_itemNotFound')

<script>
Vue.config.devtools = true;
Vue.config.debug = true;

var appTaxes = new Vue({
  el: '#taxes_index',
   data()  {
    return {
    errors:{}
  }},
  methods: {
      goEdit: function(val){
        window.location = '/taxes/'+val+'/edit';
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
                axios.delete('/taxes/'+val)
                    .then(function(response) {
                        if(response.data.deleted) {
                            swal("Eliminado!", "El registro ha sido eliminado correctamente!!.", "success");
                             $('#taxes-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');                 
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




