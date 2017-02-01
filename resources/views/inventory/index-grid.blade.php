
    {!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!} 
    {!!Html::style('/themes/krece/css/plugins/jqgrid/ui.jqGrid.css')!!}  
     {!!Html::script('/themes/krece/js/plugins/jqgrid/jquery.jqGrid52.min.js')!!}  
     {!!Html::script('/themes/krece/js/plugins/jquery-layout/jquery.layout.js')!!}
      {!!Html::script('/themes/krece/js/plugins/jqgrid/i18n/grid.locale-es.js')!!}  
       {!!Html::script('/js/vue-library/vue.min.js')!!}
    {!!Html::style('/themes/krece/css/plugins/jqueryui/jquery-ui.css')!!}

 <style>
        /* Additional style to fix warning dialog position */
        #alertmod_inventory-grid {
            top: 900px !important;
        }
          .green {color: green;}
        .red {color: red;}

    </style>

    <div class="jqGrid_wrapper"> 
        <div class="ibox-content">     
            <table id="inventory-grid"></table>
            <div id="pager_list_2"></div>     
        </div>        
    <div>

    <script>
        
        $(document).ready(function () {       
            var emptyMsgDiv = $("<div class='ibox-content ibox-heading'>" +
            "<h3><i class='fa fa-exclamation'></i> No tienes ítems creados!</h3>" +
            " <div class='ibox-content ibox-heading'><a href='{{route('inventory.create')}}' class='btn btn-primary btn-outline btn-sm '>" +
            "<span class='fa fa-plus '></span>&nbsp;Crear ítem</a> </div></div> '");
          

            $("#inventory-grid").jqGrid({
                url: "getInventorylist",               
                datatype: "json",
                mtype: 'GET',
                emptyrecords:  "",
                colModel: [                   
                    { label: 'Nombre', name: 'name', index: 'name', width: 75, sorttype: "text" },
                    { label: 'Referencia', name: 'reference', width: 90 },
                    { label: 'Precio', name: 'sale_price', width: 90,formatter: 'currency',
                    formatoptions: { decimalSeparator: '.', decimalPlaces: 2, thousandsSeparator: ',', prefix: '$' }},                    
                    { label: 'Descripción', name: 'description', width: 90 },
                     {name:'public_id',  keys: true,"width":50, label:'Acciones', index:'public_id',  "align":"right" , sortable: false, formatter: displayButtons }                  
                ],
                viewrecords: true, // show the current page, data rang and total records on the toolbar
                width: 780,
                height: 300,
                rowNum: 10,
                rowList: [10, 20, 50, 100],
                caption:"Inventario",
                loadonce:true,
                navOptions: { reloadGridOptions: { fromServer: true } },
                loadComplete: function () {
                    var count = $("#inventory-grid").getGridParam();
                    var ts = $("#inventory-grid")[0];
                    if (ts.p.reccount === 0) {
                        $("#inventory-grid").hide();
                        emptyMsgDiv.insertAfter($("#inventory-grid").parent());
                        emptyMsgDiv.show();
                    } else {
                        $("#inventory-grid").show();
                        emptyMsgDiv.hide();
                    };
                    resizewidth();
                },         
                pager:"#pager_list_2"
            });

  
         
             jQuery('#inventory-grid').jqGrid('navGrid','#pager_list_2',
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
                var edit = "<div  title= 'editar'  class='fa fa-eye green' style='cursor: pointer' onClick=app.goShow(\""+cellvalue+"\") ></div><span > </span>",
                    Details = "<div title= 'ver' class='fa fa-pencil green' style='cursor: pointer'  onClick=app.goEdit(\""+cellvalue+"\")></div><span > </span>",
                    Delete = "<div title= 'eliminar' class='fa fa-remove red'  style='cursor: pointer' onclick=app.remove(\""+cellvalue+"\")/></div><span > </span>";
                
                return edit + Details + Delete;
            }   

             $(window).bind('resize', function () {
               resizewidth();
            });
                //resize on load
            function resizewidth()
            {
                var width = $('.jqGrid_wrapper').width();
                $('#inventory-grid').setGridWidth(width); 
            }  

         

        });


    </script>

