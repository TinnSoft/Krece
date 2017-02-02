Vue.config.devtools = true;
Vue.config.debug = true;

Vue.component('modal', {
  /*template: "<transition name='modal'><div class='modal-mask'><div class='modal-wrapper'><div class=+modal-container+><div class='modal-header'>"+
            "<slot name='header'>default header</slot></div><div class='modal-footer'>"+
            "<slot name='footer'>default footer"+
              "<button class='modal-default-button' @click='$emit('close')'> OK </button></slot>"+
          "</div></div></div></div></transition>"*/
          template: '<span>{{ app.message }}</span>'
})


var app = new Vue({
  el: '#inventory',
  components: {
        "Multiselect": VueMultiselect.Multiselect
    },
  data: function() {   
    return{
      message:'aaa',
    showModal: false,
    toUseListPrice:false,
    isProcessing: false,
    name: '',
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
        //alert();   
          showModal = true;
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
