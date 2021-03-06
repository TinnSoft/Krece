
    {!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!} 
    {!!Html::style('/themes/krece/css/plugins/jqGrid/ui.jqgrid.css')!!}  
     {!!Html::script('/themes/krece/js/plugins/jqgrid/jquery.jqGrid52.min.js')!!}  
     {!!Html::script('/themes/krece/js/plugins/jquery-layout/jquery.layout.js')!!}
      {!!Html::script('/themes/krece/js/plugins/jqgrid/i18n/grid.locale-es.js')!!}  
    {!!Html::style('/themes/krece/css/plugins/jQueryUI/jquery-ui.css')!!}
    <script>
        moment.locale('es');  
    </script>
    

 <style>
          .green {color: green;}
        .red {color: red;}

    </style>
            
    <div class="table-responsive">
        <table id="paymentterms-grid"></table>
    </div>
    <div id="pager_list_2"></div>   

    <script>
        
        $(document).ready(function () {       
             var emptyMsgDiv = $("<div class='ibox-content ibox-heading'>" +
            "<h3><i class='fa fa-exclamation'></i> No tienes términos de pago creados!</h3>" +
            " <div class='ibox-content ibox-heading'><a href='{{route('list_price.create')}}' class='btn btn-primary btn-outline btn-sm '>" +
            "<span class='fa fa-plus '></span>&nbsp;Crear Término de pago</a> </div></div> '");
          

            $("#paymentterms-grid").jqGrid({
                url: "/getPaymentTermsList",
                datatype: "json",
                mtype: 'GET',
                emptyrecords:  "",
                colModel: [                   
                    { label: 'Nombre', name: 'name', index: 'name' },
                    { label: 'Días', name: 'days', sorttype: "number",formatter:{integer : {thousandsSeparator: " ", defaultValue: '0'}} },     
                    {name:'public_id', search:false, keys: true,label:'Acciones', index:'public_id',  "align":"right" , sortable: false, formatter: displayButtons }                  
                ],
                viewrecords: true, // show the current page, data rang and total records on the toolbar
                autowidth: true,
                autoresizeOnLoad: true,
                autoResizing: {
                    compact: true
                    },
                 cmTemplate: {
                    autoResizable: true,
                    editable: true
                    },
                shrinkToFit: true,
                height: 'auto',
                rowNum: 10,
                rowList: [10, 20, 50, 100],
                caption:" ",
                loadonce:true,
                navOptions: { reloadGridOptions: { fromServer: true } },
                loadComplete: function () {
                    var count = $("#paymentterms-grid").getGridParam();
                    var ts = $("#paymentterms-grid")[0];
                    if (ts.p.reccount === 0) {
                        $("#paymentterms-grid").hide();
                        emptyMsgDiv.insertAfter($("#paymentterms-grid").parent());
                        emptyMsgDiv.show();
                    } else {
                        $("#paymentterms-grid").show();
                        emptyMsgDiv.hide();
                    };
                },     
                   
                pager:"#pager_list_2"
            });
            
            

             jQuery('#paymentterms-grid').jqGrid('navGrid','#pager_list_2',
                {
                    "edit":false,
                    "add":false,
                    "del":false,
                    "search":true,
                    "refresh":false,
                    "view":false,
                    "excel":false,
                    "pdf":false,
                    "csv":false,
                    "columns":false
                },
                {"drag":true,"resize":true,"closeOnEscape":true,"dataheight":150},
                {"drag":true,"resize":true,"closeOnEscape":true,"dataheight":150}
                );
                                
              setTimeout(function(){
                $('.wrapper-content').removeClass('animated fadeInRight');
            },700);


             function displayButtons(cellvalue, options, rowObject) {

                var edit = "<div  title= 'editar'  class='fa fa-pencil green fa-2x' style='cursor: pointer' onClick=appPaymentTerm.goEdit(\""+cellvalue+"\") ></div><span > </span>",
                    Delete = "<div title= 'eliminar' class='fa fa-remove red fa-2x'  style='cursor: pointer' onclick=appPaymentTerm.remove(\""+rowObject.id+"\")/></div><span > </span>";
                    
                  if (rowObject.name=='Vencimiento manual' || rowObject.name=='De Contado')
                  { 
                    edit = "<div  title= 'Editar'  class='fa fa-pencil fa-2x ' style='color:#ABEBC6'/></div><span > </span>";                                           
                    Delete = "<div title= 'Eliminar' class='fa fa-remove fa-2x '  style='color:#F3D8D5'/></div><span > </span>"; 
                  }

                return edit+ Delete;
            }   

           
              $(window).on("resize", function() {
                resizewidth();
            });
             $(window).bind('resize', function () {
               resizewidth();
            });
                //resize on load
            function resizewidth()
            {
                var newWidth = $("#paymentterms-grid").closest(".ui-jqgrid").parent().width();
                $("#paymentterms-grid").jqGrid("setGridWidth", newWidth, true);
            }  

            	// activate the toolbar searching
			$('#paymentterms-grid').jqGrid('navGrid',"#pager_list_2", {                
                search: false, // show search button on the toolbar
                add: false,
                edit: false,
                del: false,
                refresh: true
            });
			var timer;
			

        });


    </script>

