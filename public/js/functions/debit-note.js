Vue.config.devtools = true;
Vue.config.debug = true;

var DNapp = new Vue({
  el: '#debitnote',
  components: {
    "Multiselect": VueMultiselect.Multiselect
  },
  data: function () {
    return {
      isProcessing: false,
      name: '',
      form: {},
      errors: {},
      customer_list: [],
      currency: [],
      product_list: [],
      taxes: [],
      redirect: '/debit-note/',
    }
  },
  //similar on load event

  created: function () {
    this.fetchData();
    Vue.set(this.$data, 'form', _form);
  },
  beforeMount() {
    this.getCurrentDate();
  },

  methods: {
    onInputContact: function (val) {
      if (val) {
        this.form.customer_id = val.id;
      }
      else {
        this.form.customer_id = '';
      }
    },

    onInputTax: function (val) {
      if (val.taxes) {
        val.tax_amount = val.taxes.value;

        val.tax_id = val.taxes.id;
      }
      else {
        val.tax_amount = "";
        val.tax_id = '';
      }
    },
    onInputCurrency: function (val) {
      if (val)
      { this.form.currency_code = val.code; }
      else
      { this.form.currency_code = ''; }
    },
    onInputProduct: function (val) {
      if (val.category) {
        val.category_id = val.category.id;       
        val.name = val.category.name;
      }
      else {
        val.category_id = ""; 
        val.name = '';
      }
    },
    currencyLabel({
      code,
      symbol
    }) {
      if (code) {
        if (!symbol) {
          symbol = "$";
        }
        return `${code} — [${symbol}]`
      }
    },

    getCurrentDate: function () {
      var d = new Date();
      var n = d.toLocaleDateString();
      if (this.form.date == "") {
        this.form.date = n;
      }
    },
    addLine: function (e) {
      this.form.detail.push({
        category_id: null,
        name: '',
        description: '',
        unit_price: 0,
        discount: 0,
        quantity: 1,
        tax_amount: 0
      });
    },
    removeItem: function (detail) {
      var index = this.form.detail.indexOf(detail)
      this.form.detail.splice(index, 1);
    },
    fetchData: function () {
      //carga de los datos del header
      var vm = this
      axios.get('/getDebitNoteBaseInfo')
        .then(function (response) {
          Vue.set(vm.$data, 'customer_list', response.data.contacts);
          Vue.set(vm.$data, 'currency', response.data.currency);
          Vue.set(vm.$data, 'taxes', response.data.taxes);
          Vue.set(vm.$data, 'product_list', response.data.productlist);

          if (vm.$data.form.public_id == "") {
            vm.$data.form.public_id = response.data.public_id;
          }

          if (vm.$data.form.resolution_id == "") {
            vm.$data.form.resolution_id = response.data.resolution_id.number;
          }

          if (!vm.$data.form.currency) {
            Vue.set(vm.$data.form, 'currency', response.data.default_Currency);
            Vue.set(vm.$data.form, 'currency_code', response.data.default_Currency.code_id);
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
    subTotal: function () {
      var _subtotal = this.form.detail.reduce(function (carry, detail) {
        return carry + (parseFloat(detail.quantity) * parseFloat(detail.unit_price));
      }, 0);
      _subtotal = isNaN(_subtotal) ? 0 : _subtotal;
      this.form.sub_total = _subtotal;
      return _subtotal;
    },
    DiscountsTotal: function () {
      var discountsTot = this.form.detail.reduce(function (carry, detail) {
        return carry + (((parseFloat(detail.quantity) * parseFloat(detail.unit_price)) * parseFloat(detail.discount))) / 100;
      }, 0);
      this.form.total_discounts = isNaN(discountsTot) ? 0 : discountsTot;
      return isNaN(discountsTot) ? 0 : discountsTot
    },

    TaxesTotal: function () {
       var TaxTot = this.form.detail.reduce(function (carry, detail) {
        return carry + ((((parseFloat(detail.quantity) * parseFloat(detail.unit_price))
          - ((parseFloat(detail.quantity) * parseFloat(detail.unit_price)) * parseFloat(detail.discount)) / 100) *
           parseFloat(isNaN(detail.tax_amount) || detail.tax_amount=='' ? 0 : detail.tax_amount))) / 100;
      }, 0);

      this.form.total_taxes = isNaN(TaxTot) ? 0 : TaxTot;

      return isNaN(TaxTot) ? 0 : TaxTot
    },

    grandTotal: function () {
      var totalval = (isNaN(this.subTotal) ? 0 : parseFloat(this.subTotal)) -
        (isNaN(this.DiscountsTotal) ? 0 : parseFloat(this.DiscountsTotal)) + (isNaN(this.TaxesTotal) ? 0 : parseFloat(this.TaxesTotal));


      this.form.total = totalval;
      return isNaN(totalval) ? 0 : totalval
    }
  }
})


/*Formato de moneda */
Vue.filter('formatCurrency', function (value) {
  return accounting.formatMoney(value);
});
