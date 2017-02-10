Vue.config.devtools = true;
Vue.config.debug = true;

var appResolution = new Vue({
  el: '#resolution',
  data: function() {   
    return{
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
      Vue.set(this.$data, 'form', _form); 
    },
  methods: {
    
      create: function() {      
          var vm = this;
          vm.isProcessing = true;
          axios.post('/resolution', vm.form)
            .then(function (response) {
              if(response.data.created) { 
                 toastr.success('Registro creado correctamente', 'Creado', {timeOut: 5000});               
                window.location = '/resolution/';
              } else {
                vm.isProcessing = false;
                toastr.error('No se ha podido crear el registro, intente de nuevo.', 'Error', {timeOut: 5000});
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
        axios.put('/resolution/' + vm.form.id, vm.form)
          .then(function(response) {
            if(response.data.updated) {                     
              window.location = '/resolution/';
               toastr.success('Registro actualizado correctamente', 'Actualizado', {timeOut: 5000});          
            } else {             
              vm.isProcessing = false;
               toastr.error('No se ha podido actualizar el registro, intente de nuevo.', 'Error', {timeOut: 5000});
            }
          })
          .catch(function(error) {
            vm.isProcessing = false;
            Vue.set(vm.$data, 'errors', error.response.data);
           
          })
      }   
    }
 
})
