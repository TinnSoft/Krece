
    {!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!} 
    {!!Html::style('/themes/krece/css/plugins/jqgrid/ui.jqGrid.css')!!}  
     {!!Html::script('/themes/krece/js/plugins/jqgrid/jquery.jqGrid52.min.js')!!}  
     {!!Html::script('/themes/krece/js/plugins/jquery-layout/jquery.layout.js')!!}
      {!!Html::script('/themes/krece/js/plugins/jqgrid/i18n/grid.locale-es.js')!!}  
    {!!Html::style('/themes/krece/css/plugins/jqueryui/jquery-ui.css')!!}
    <script>
        moment.locale('es');  
    </script>
    

 <style>
          .green {color: green;}
        .red {color: red;}

    </style>
            
    <div class="table-responsive">
        <table id="retention-grid"></table>
    </div>
    <div id="pager_list_2"></div>   

    <script>
        
        $(document).ready(function () {       
             var emptyMsgDiv = $("<div class='ibox-content ibox-heading'>" +
            "<h3><i class='fa fa-exclamation'></i> No tienes términos de pago creados!</h3>" +
            " <div class='ibox-content ibox-heading'><a href='{{route('list_price.create')}}' class='btn btn-primary btn-outline btn-sm '>" +
            "<span class='fa fa-plus '></span>&nbsp;Crear Término de pago</a> </div></div> '");
          

            $("#retention-grid").jqGrid({
                url: "/getRetentionList",
                datatype: "json",
                mtype: 'GET',
                emptyrecords:  "",
                colModel: [                   
                    { label: 'Nombre', name: 'name', index: 'name' },
                    { label: 'Porcentage(%)', name: 'value',width: 80, sorttype: "number",formatter:{number : {decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaultValue: '0.00'}} },     
                    { label: 'Tipo', name: 'retention_type.name', index: 'name' },
                    { label: 'Descripción', name: 'description', index: 'name' },
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
                    var count = $("#retention-grid").getGridParam();
                    var ts = $("#retention-grid")[0];
                    if (ts.p.reccount === 0) {
                        $("#retention-grid").hide();
                        emptyMsgDiv.insertAfter($("#retention-grid").parent());
                        emptyMsgDiv.show();
                    } else {
                        $("#retention-grid").show();
                        emptyMsgDiv.hide();
                    };
                },     
                   
                pager:"#pager_list_2"
            });
            
            

             jQuery('#retention-grid').jqGrid('navGrid','#pager_list_2',
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
                var edit = "<div  title= 'editar'  class='fa fa-pencil green fa-2x' style='cursor: pointer' onClick=appRetention.goEdit(\""+cellvalue+"\") ></div><span > </span>",
                    Delete = "<div title= 'eliminar' class='fa fa-remove red fa-2x'  style='cursor: pointer' onclick=appRetention.remove(\""+rowObject.id+"\")/></div><span > </span>";
                    
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
                var newWidth = $("#retention-grid").closest(".ui-jqgrid").parent().width();
                $("#retention-grid").jqGrid("setGridWidth", newWidth, true);
            }  

            	// activate the toolbar searching
			$('#retention-grid').jqGrid('navGrid',"#pager_list_2", {                
                search: false, // show search button on the toolbar
                add: false,
                edit: false,
                del: false,
                refresh: true
            });
			var timer;
			

        });


    </script>

