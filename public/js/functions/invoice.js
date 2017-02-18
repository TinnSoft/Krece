Vue.config.devtools = true;
Vue.config.debug = true;

var app = new Vue({
  el: '#invoice',
  components: {
    "Multiselect": VueMultiselect.Multiselect
  },
  data: function () {
    return {
      wasSetByDefault: false,
      isProcessing: false,
      name: '',
      numerationList_sale_order: [],
      form: {},
      errors: {},
      customer_list: [],
      paymentTerms: [],
      vendors: [],
      currency: [],
      listPrice: [],
      product_list: [],
      taxes: [],
      redirect: '/invoice/',
    }
  },
  //similar on load event

  created: function () {
    var vm = this;
    vm.fetchData();
    Vue.set(vm.$data, 'form', _form);
    Vue.set(vm.$data.form, 'ResolutionIsAutoNumeric', false);

  },
  beforeMount() {
    var vm = this;
    vm.getCurrentDate();

  },

  methods: {

    checkNumeration: function () {
      var vm = this;
      if (vm.numerationList_sale_order.length > 1) {
        return true;
      }
      else {
        vm.form.resolution = vm.numerationList_sale_order[0];
        vm.onInputResolutionList(vm.form.resolution);

        if (vm.form.ResolutionIsAutoNumeric == false) {
          return true;
        }
        return false;
      }

    },
    onInputResolutionList: function (val) {
      var vm = this;
      if (val) {
        if (val.auto_increment == 1) {
          Vue.set(vm.$data.form, 'ResolutionIsAutoNumeric', true);
          vm.form.resolution_id = val.id;
          vm.form.resolution_number = val.next_invoice_number;
          vm.form.prefix = val.prefix;
        }
        else {
          Vue.set(vm.$data.form, 'ResolutionIsAutoNumeric', false);
          vm.form.resolution_id = val.id;
          vm.form.resolution_number = '';
          vm.form.prefix = '';
        }

        if (val.isDefault == 1 || val.auto_increment == 1) {
          vm.wasSetByDefault = true;
        }
        else {
          vm.wasSetByDefault = false;
        }
      }
    },
    onInputpaymentTerms: function (val) {
      if (val) {
        this.form.payment_terms_id = val.id;

        var d = new Date();
        d.setDate(d.getDate() + val.days);
        this.form.due_date = d.toLocaleDateString();
      }
      else
      { this.form.payment_terms_id = ''; }
    },
    onInputContact: function (val) {
      if (val) {
        this.form.customer_id = val.id;
        if (val.seller) {
          this.form.seller = val.seller;
          this.form.seller_id = val.seller.id;
        }
        else {
          this.form.seller_id = '';
          this.form.seller = null;
        }
      }
      else {
        this.form.customer_id = '';
        this.form.seller_id = '';
      }
    },
    onInputSeller: function (val) {
      if (val) {
        this.form.seller_id = val.id;
      }
      else
      { this.form.seller_id = ''; }
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
    onInputlistprice: function (val) {
      if (val)
      { this.form.list_price_id = val.id; }
      else
      { this.form.list_price_id = ''; }
    },
    onInputCurrency: function (val) {
      if (val)
      { this.form.currency_code = val.code; }
      else
      { this.form.currency_code = ''; }
    },
    onInputProduct: function (val) {
      if (val.product) {
        val.description = val.product.description;
        val.unit_price = val.product.sale_price;
        val.product_id = val.product.id;
        val.reference = val.product.reference;
        val.name = val.product.name;
      }
      else {
        val.product_id = "";
        val.description = '';
        val.unit_price = 0;
        val.product_id = '';
        val.reference = '';
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

      if (this.form.date == "") {
        this.form.date = d.toLocaleDateString();
        this.form.due_date = d.toLocaleDateString();
      }
    },
    addLine: function (e) {
      this.form.detail.push({
        product_id: null,
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
      axios.get('/getInvoiceBaseInfo')
        .then(function (response) {
          Vue.set(vm.$data, 'customer_list', response.data.contacts);
          Vue.set(vm.$data, 'currency', response.data.currency);
          Vue.set(vm.$data, 'listPrice', response.data.listprice);
          Vue.set(vm.$data, 'vendors', response.data.sellers);
          Vue.set(vm.$data, 'product_list', response.data.productlist);
          Vue.set(vm.$data, 'taxes', response.data.taxes);
          Vue.set(vm.$data, 'paymentTerms', response.data.paymentTerms);
          Vue.set(vm.$data, 'numerationList_sale_order', response.data.numerationList_sale_order);
          Vue.set(vm.$data.form, 'resolution_number', response.data.resolution_id['next_invoice_number']);

          vm.numerationList_sale_order.forEach(function (item) {
            if (item.isDefault == 1) {
              vm.form.resolution = item;
              vm.form.resolution_id = item.id;
              vm.wasSetByDefault = true;
            }
          });

          //default values
          if (!vm.$data.form.list_price) {
            Vue.set(vm.$data.form, 'list_price', response.data.list_price);
            Vue.set(vm.$data.form, 'list_price_id', response.data.list_price.id);
          }

          if (!vm.$data.form.currency) {
            Vue.set(vm.$data.form, 'currency', response.data.default_Currency);
            Vue.set(vm.$data.form, 'currency_code', response.data.default_Currency.code_id);
          }


          if (vm.$data.form.public_id == "") {
            vm.$data.form.public_id = response.data.public_id;
          }

          if (vm.$data.form.resolution_number == '') {
            vm.$data.form.resolution_number = response.data.resolution_number.number;
            vm.$data.form.resolution_id = response.data.resolution_number.id;
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
          parseFloat(detail.tax_amount))) / 100;
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
