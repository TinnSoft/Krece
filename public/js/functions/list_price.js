Vue.config.devtools = true;
Vue.config.debug = true;

var app = new Vue({
  el: '#list_price',
  data()  {
    return {
    isProcessing: false,
    form: {},
    errors: {}
  }},

  created: function () {  
      Vue.set(this.$data, 'form', _form); 
    },
  watch: {
    'form.type_id': function (val) {
      if (val==2)
      {
        this.form.value=0;
      }     
    }
  },
  methods: {
      create: function() {      
          var vm = this;
          vm.isProcessing = true;
          axios.post('/list_price', vm.form)
            .then(function (response) {
              if(response.data.created) {          
                window.location = '/list_price';
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
        axios.put('/list_price/' + vm.form.id, vm.form)
          .then(function(response) {
            if(response.data.updated) {
              toastr.success('Registro actualizado correctamente.', 'Actualizado', {timeOut: 5000});
              window.location = '/list_price';               
            } else {             
              vm.isProcessing = false;
              toastr.warning('No se ha podido actualizar el registro, intente de nuevo.', 'Error', {timeOut: 5000});
            }
          })
          .catch(function(error) {
            vm.isProcessing = false;
            Vue.set(vm.$data, 'errors', error.response.data);
            toastr.error('No se ha podido actualizar el registro, intente de nuevo.', 'Error', {timeOut: 5000});
          })
      }   
    }  
})


