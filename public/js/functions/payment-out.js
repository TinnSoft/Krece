Vue.config.devtools = true;
Vue.config.debug = true;

var app = new Vue({
  el: '#payment-out',
  components: {
    "Multiselect": VueMultiselect.Multiselect
  },
  data: function () {
    return {
      hasPendingPayment: 1,
      isProcessing: false,
      kindOfProcess: {},
      form: {},
      errors: {},
      customer_list: [],
      paymentmethod: [],
      currency: [],
      bank: [],
      redirect: '/payment-out/',
      category_list:[],
      taxes:[]
    }
  },
  //similar on load event

  created: function () {
    this.fetchData();
    Vue.set(this.$data, 'form', _form);
    Vue.set(this.$data, 'kindOfProcess', _kindOfProcess);
    this.getInvoice_list();
  },
  beforeMount() {
    this.getCurrentDate();
  },

  methods: {
    goShow: function (val) {
      window.location = '/bill/' + val;
    },
    addLine: function () {
      this.form.payment_out_to_category.push({
        category_id: '',
        category:null,
        unit_price: '',
        tax_id: '',
        quantity: 1,
        tax_value:null,
        observations:''
      });
    },
     onInputCategory: function (val) {
      if (val.category) {       
        val.category_id = val.category.id;
      }
      else {
        val.category_id = "";
      }
    },
     onInputTax: function (val) {
      if (val.tax_value) {
        val.tax_amount = val.tax_value.value;
        val.tax_id=val.tax_value.id;
      }
      else {
        val.tax_amount = "";
        val.tax_id="";
      }
    },
     removeItem: function (detail) {
      var index = this.form.payment_out_to_category.indexOf(detail)
      this.form.payment_out_to_category.splice(index, 1);
    },
    //obtener el listado de facturas de compra pendientes por pagar
    getInvoice_list: function () {
      var vm = this;
      var procedure_path = '';
      if(vm.form.isInvoice == 1) //Pago asociado a factura de compra
      {
        Vue.delete(vm.$data.form, 'payment_out_to_category', []);

        if (vm.kindOfProcess == "edit") {
          procedure_path = '/getInvoicePendingtoPay_edit_out/'
        }
        else {
          procedure_path = '/getInvoicePendingtoPay_out/'
        }
      }
      else{ //pago asociado a categoría
        Vue.delete(vm.$data.form, 'pending_payment_out', []);
        Vue.set(vm.$data.form, 'payment_out_to_category', []);
        this.addLine();
         procedure_path = '/payment_out_ToCategorySection/'
      }


      vm.hasPendingPayment = 1;//determina si el cliente seleccionado tiene o no pagos pendientes, si NO muestra un warning
      if (vm.form.isInvoice == 1 && vm.form.customer_id != '') {       
          axios.get(procedure_path + vm.form.customer_id)
          .then(function (response) {
            Vue.set(vm.$data.form, 'pending_payment_out', response.data.PendingByPayment);

            if (response.data.PendingByPayment.length == 0) {
              vm.hasPendingPayment = 0;
            }

          })
          .catch(function (error) {
            Vue.set(vm.$data, 'errors', error);
          })
      }
      else if(vm.form.isInvoice == 0){
        axios.get(procedure_path)
          .then(function (response) {
             Vue.set(vm.$data, 'category_list', response.data.category);
              Vue.set(vm.$data, 'taxes', response.data.taxes);
          })
          .catch(function (error) {
            Vue.set(vm.$data, 'errors', error);
          })
        
      }
    },
    DisplayPendingInvoiceSale: function () {
      var vm = this;
      if (vm.form.isInvoice == 1 && vm.form.customer_id != '') {
        if (vm.form.pending_payment_out) {
          if (vm.form.pending_payment_out.length > 0) {
            return true;
          }
        }
      }
      return false;
    },

    wasCustomerSelected: function () {
      var vm = this;
      if (vm.form.isInvoice == 1 && vm.form.customer_id == '') {
        return false;
      }
      return true;
    },
    onInputContact: function (val) {

      if (val != '' && val) {
        this.form.customer_id = val.id;
        this.getInvoice_list();
      }
      else {
        this.form.customer_id = '';
      }
    },
    onInputBank: function (val) {
      if (val)
      { this.form.bank_account_id = val.id; }
      else
      { this.form.bank_account_id = ''; }
    },

    onInputPaymentMethod: function (val) {
      if (val)
      { this.form.payment_method_id = val.id; }
      else
      { this.form.payment_method_id = ''; }
    },

    getCurrentDate: function () {
      var d = new Date();
      var n = d.toLocaleDateString();
      if (this.form.date == "") {
        this.form.date = n;
      }
    },

    fetchData: function () {
      //carga de los datos del header
      var vm = this
      axios.get('/getPaymentOut_BaseInfo')
        .then(function (response) {
          Vue.set(vm.$data, 'customer_list', response.data.contacts);
          Vue.set(vm.$data, 'paymentmethod', response.data.paymentmethod);
          Vue.set(vm.$data, 'bank', response.data.bank);

          if (vm.$data.form.resolution_id == "") {
            vm.$data.form.resolution_id = response.data.resolution_id.number;
          }

        })
        .catch(function (error) {
          Vue.set(vm.$data, 'errors', error);
        })
    },
    create: function () {
      var vm = this;
      vm.isProcessing = true;
      axios.post(vm.redirect, vm.form)
        .then(function (response) {
          if (response.data.created) {
            window.location = vm.redirect + response.data.id;
          } else {
            vm.isProcessing = false;
          }
        })
        .catch(function (error) {
          vm.isProcessing = false;
          Vue.set(vm.$data, 'errors', error.response.data);
        });
    },

    update: function () {
      var vm = this;
      vm.isProcessing = true;
      axios.put(vm.redirect + vm.form.id, vm.form)
        .then(function (response) {
          if (response.data.updated) {
            vm.isProcessing = false;
            window.location = vm.redirect + response.data.id;;
          } else {
            vm.isProcessing = false;
          }
        })
        .catch(function (error) {
          vm.isProcessing = false;
          Vue.set(vm.$data, 'errors', error.response.data);
        })
    }
  },
  //valores calculados
  computed: {
    GrandTotal: function () {
      var _total = this.form.pending_payment_out.reduce(function (carry, pending_payment_out) {
        return carry + (parseFloat(pending_payment_out.amount_receipt));
      }, 0);
      _total = isNaN(_total) ? 0 : _total;
      this.form._total = _total;
      return _subtotal;
    }


  }
})


/*Formato de moneda */
Vue.filter('formatCurrency', function (value) {
  return accounting.formatMoney(value);
});
