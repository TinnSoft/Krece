
@extends('home',['title' =>  'Categorias'])

   

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
                    <h2><span class="fa fa-book"></span>  Configuración de mi Contabilidad</h2>
                    <ol class="breadcrumb">
                        <li class="active">
                            <strong>Inicio</strong>      
                        </li>
                    </ol>
                </div>                
            </div>           

   <div id="inventory_index"  class="row  border-bottom white-bg dashboard-header">
        <div class="panel-body">
            <div class="ibox-content">                                
                    @include('category.category-grid')                     
            </div>            
        </div>      
    </div>


   @include('partials.category_modal')


@include('partials.warm_itemNotFound')

<script>
var categoryApp = new Vue({
  el: '#inventory_index',
   data:function()  {
    return {
        header_modal:"",
        modal_isEdit:false,
        category:{
            parent_id:'',
            name:'',
            description:'',
            niif_account:''
        },
        errors:{},
        form:{
            isActive:null,
            validate:true
    }
  }},
  methods: {
       setCategoryId: function(val)
      {
        if (val)
        {
          var vm=this;
           Vue.set(vm.$data.form, 'category_id', val);
        }
      }, 
     addNewNode: function(e) {  
        var vm = this;
        if(e)
        {   
           this.header_modal="Nueva Categoría";    
          Vue.set(vm.$data.category, 'parent_id', e);
          this.category.name='';
          this.category.niif_account='';
          this.category.description='';
          this.modal_isEdit=false;
          $('#categoryModal').modal('toggle');  
        }
      },
      updateNode: function(desc,name,id,account) {
        var vm = this;
    
        if(id)
        {   
          this.header_modal="Editar Categoría";   
          this.modal_isEdit=true;
          Vue.set(vm.$data.category, 'parent_id', id);
          Vue.set(vm.$data.category, 'name', name);
          Vue.set(vm.$data.category, 'description', desc);
          Vue.set(vm.$data.category, 'niif_account', account);
      
          $('#categoryModal').modal('toggle');  
        }
      },
       Modal_click_save:function(){
        if(this.modal_isEdit==true)
        {
          this.UpdateCategory();
        }
        else{
          this.saveNewCategory();
        }
     },
     saveNewCategory: function() { 
         var vm = this;
          vm.isProcessing = true;
          axios.post('/category', vm.category)
            .then(function (response) {
              if(response.data.created) {  
                 $('#category-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');         
                 $('#categoryModal').modal('toggle');                  
              } else {
                vm.isProcessing = false;
              }
            })
            .catch(function (error) {        
              vm.isProcessing = false;
              Vue.set(vm.$data, 'errors', error.response.data);
            });
      },
      remove:function(val) {
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
                  axios.delete('/category/' + val)
                      .then(function(response) {
                          if(response.data.deleted) {
                              swal("Eliminado!", "El registro ha sido eliminado correctamente!!.", "success");
                              $('#category-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
                          }
                      })
                      .catch(function(error) {                       
                          swal("Error!", "El registro no se ha eliminado correctamente, intente de nuevo!!.", "error");                        
                      })
            
          } else {
            swal("Cancelado", "Cancelado :)", "error");
          }
        }.bind(this)); 
    },
  }
})
</script>

@endsection




