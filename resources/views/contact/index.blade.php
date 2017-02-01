
@extends('home')

   

@section('content')
  
    <style>
        .green {color: green;}
        .red {color: red;}
    </style>

 {!!Html::script('/js/vue-library/vue.min.js')!!}
  {!!Html::script('/js/libraries/axios.min.js')!!}
{!!Html::script('/js/functions/DataTable_initializer.js')!!}
{!!Html::style('/themes/krece/css/plugins/sweetalert/sweetalert.min.css')!!}  
  {!!Html::script('/themes/krece/js/plugins/sweetalert/sweetalert.min.js')!!}  

    <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-4">
                    <h2><span class="fa fa-group"></span>   Gestión de Contactos</h2>
                    <ol class="breadcrumb">
                        <li class="active">
                            <strong>Inicio</strong>      
                        </li>
                    </ol>
                </div>                
            </div>           

   <div id="contact"  class="row  border-bottom white-bg dashboard-header">
        <div class="panel-body">
                <div class="ibox-content">   
                    <div class="row">
                            <a href="{{route('contact.create')}}" class="btn btn-primary btn-sm pull-right"> 
                            <span class="glyphicon glyphicon-plus"></span>&nbsp;Nuevo Contacto</a>                     
                    </div>                    
                </div>  
               <div class="ibox-content">                                
                    @include('contact.contact-grid')                     
                </div>  
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
  el: '#contact',
   data()  {
    return {
    idsel:""
  }},
  methods: {
    goShow: function(val){
        window.location = '/contact/'+val;
      },
      goEdit: function(val){
        window.location = '/contact/'+val+'/edit';
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
                axios.delete('/contact/' + val)
                    .then(function(response) {
                        if(response.data.deleted) {
                            swal("Eliminado!", "El registro ha sido eliminado correctamente!!.", "success");
                             $('#contact-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
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




