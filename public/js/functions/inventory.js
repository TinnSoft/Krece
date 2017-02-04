Vue.config.devtools = true;
Vue.config.debug = true;


var app = new Vue({
  el: '#inventory',
  components: {
        "Multiselect": VueMultiselect.Multiselect
    },
  data: function() {   
    return{ 
    header_modal:"",
    modal_isEdit:false,  
    toUseListPrice:false,
    isProcessing: false,
    name: '',
    category:{
        parent_id:'',
        name:'',
        description:'',
        niif_account:''
    },
    form: {},
    errors: {},
    measure_unit: [],
    listPrice:[],   
    taxes:[]
  }},
  created: function () {  
      this.fetchData();
      Vue.set(this.$data, 'form', _form); 
    },
  watch:
  {
   'toUseListPrice': function(val)
    {
      if (val)
      {
        if (this.form.list_price_id)
        {
          isProcessing: true;
        }
      }
      else{
         isProcessing: false;
      }
    }
  },
  methods: { 
    
      //actualiza el id de categoria luego de haberlo seleccionado en el grid
      setCategoryId: function(val)
      {
        if (val)
        {
          var vm=this;
           Vue.set(vm.$data.form, 'category_id', val);
        }
      }, 
      toggleLListPrice: function () 
      {
        return this.toUseListPrice = this.toUseListPrice == true ? false : true
      },     
      onInputlistprice:function(val)
      {
        if(val)
        {this.form.list_price_id=val.id; }
        else
        {this.form.list_price_id=''; }      
      },
      onInputTax:function(val)
      {
        if(val)
        {this.form.tax_id=val.id; }
        else
        {this.form.tax_id=''; }      
      },
      onInputUnitMeasure:function(val)
      {
        if(val)
        {this.form.inv_type_id=val.id; }
        else
        {this.form.inv_type_id=''; }    
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
     UpdateCategory:function(){
       var vm = this;    
        vm.isProcessing = true;
        axios.put('/category/' + vm.category.parent_id, vm.category)
          .then(function(response) {
            if(response.data.updated) {           
               $('#category-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');         
                 $('#categoryModal').modal('toggle');       
            } else {             
              vm.isProcessing = false;  
            }
          })
          .catch(function(error) {
            vm.isProcessing = false;
            Vue.set(vm.$data, 'errors', error.response.data);
          })
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
      fetchData: function()
      {    
        //carga de los datos del header
        var vm = this
                  axios.get('/getInventoryBaseInfo')
                      .then(function(response) {  
                          Vue.set(vm.$data, 'taxes', response.data.taxes);
                          Vue.set(vm.$data, 'listPrice', response.data.listprice);
                          Vue.set(vm.$data, 'measure_unit', response.data.measure_unit);
                      })
                      .catch(function(error) {
                          console.log(error)
                      })                  
      },
      create: function() {      
          var vm = this;
          vm.isProcessing = true;
          axios.post('/inventory', vm.form)
            .then(function (response) {
              if(response.data.created) {          
                window.location = '/inventory/' + response.data.id;
              } else {
                vm.isProcessing = false;
              }
            })
            .catch(function (error) {        
              vm.isProcessing = false;
              Vue.set(vm.$data, 'errors', error.response.data);
            });
      },

      update: function() {
        var vm = this;    
        vm.isProcessing = true;
        axios.put('/inventory/' + vm.form.id, vm.form)
          .then(function(response) {
            if(response.data.updated) {           
              window.location = '/inventory/' + response.data.id;
            } else {             
              vm.isProcessing = false;
            }
          })
          .catch(function(error) {
            vm.isProcessing = false;
            Vue.set(vm.$data, 'errors', error.response.data);
          })
      }   
    }
 
})
