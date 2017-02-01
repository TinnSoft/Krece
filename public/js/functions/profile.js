Vue.config.devtools = true;
Vue.config.debug = true;

var app = new Vue({
  el: '#profile',
  data()  {
    return {
    isProcessing: false,
    form: {},
    errors: {}
  }},
  created: function () {  
      Vue.set(this.$data, 'form', _form); 
    },

  methods: { 
      update: function() {
      var vm = this;    
        vm.isProcessing = false;
        axios.put('/profile/' + vm.form.id, vm.form)
          .then(function(response) {
            if(response.data.updated) {
             // window.location = '/profile/';
              toastr.success('Registro actualizado correctamente.', 'Actualizado', {timeOut: 5000});
            } else {     
            }
          })
          .catch(function(error) {          
            Vue.set(vm.$data, 'errors', error.response.data);
            toastr.error('No se ha podido actualizar el registro, intente de nuevo.', 'Error', {timeOut: 5000});
          })
      }   
    }
  
})
