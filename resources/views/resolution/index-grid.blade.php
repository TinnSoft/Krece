
    {!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!} 
    {!!Html::style('/themes/krece/css/plugins/jqgrid/ui.jqGrid.css')!!}  
     {!!Html::script('/themes/krece/js/plugins/jqgrid/jquery.jqGrid52.min.js')!!}  
     {!!Html::script('/themes/krece/js/plugins/jquery-layout/jquery.layout.js')!!}
      {!!Html::script('/themes/krece/js/plugins/jqgrid/i18n/grid.locale-es.js')!!}  
       {!!Html::script('/js/vue-library/vue.min.js')!!}
    {!!Html::style('/themes/krece/css/plugins/jqueryui/jquery-ui.css')!!}



    <div class="jqGrid_wrapper"> 
        <div class="ibox-content">     
            <table id="resolution-grid"></table>
            <div id="pager_list_2"></div>     
        </div>        
    <div>

    <script>
        
        $(document).ready(function () {       
        

            $("#resolution-grid").jqGrid({
                url: "/getresolutionlist",               
                datatype: "json",
                mtype: 'GET',
                colModel: [                   
                    { label: 'Nombre', name: 'name', index: 'name', width: 75,   sorttype: "text" },
                    { label: 'Prefijo', name: 'prefix', width: 40 },
                    { label: 'Número Inicial', name: 'initial_number', width: 60},                    
                    { label: 'Preferido', name: 'isDefault', width: 90,formatter: default_mask },
                    { label: 'Estado', name: 'isActive', width: 50,align:"center", formatter:state_mask },
                     { label: 'Resolución', name: 'invoice_text', width: 160 },
                    {name:'public_id',  keys: true,"width":50, label:'Acciones', index:'public_id',  "align":"right" , 
                     sortable: false, formatter: displayButtons }
                ],
                viewrecords: true, 
                width: 780,
                height: 300,
                rowNum: 10,
                rowList: [10, 20, 50, 100],               
                loadonce:true,               
                loadComplete: function () {
                    var count = $("#resolution-grid").getGridParam();
                    var ts = $("#resolution-grid")[0];
                    if (ts.p.reccount === 0) {
                        $("#resolution-grid").hide();                      
                    } else {
                        $("#resolution-grid").show();
                    };
                    resizewidth();
                },         
                pager:"#pager_list_2"
            });

         
             jQuery('#resolution-grid').jqGrid('navGrid','#pager_list_2',
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
                                
        

             function displayButtons(cellvalue, options, rowObject) {
                 console.log(cellvalue);
                var edit = "<div  title= 'Editar'  class='fa fa-pencil ' style='cursor: pointer ; color:green' onClick=appresolution.goEdit(\""+cellvalue+"\") ></div><span > </span>";
                    Delete = "<div title= 'Eliminar' class='fa fa-remove '  style='cursor: pointer; color:red' onclick=appresolution.remove(\""+cellvalue+"\")/></div><span > </span>";
                    Lock = "<div title= 'Desactivar' class='fa fa-unlock '  style='cursor: pointer; color:#DDB215' onclick=appresolution.updateItemStatus(\""+rowObject.id+"\",'0')/></div><span > </span>";
                
                if (rowObject.isActive==0)
                {
                    Delete = "<div title= 'Eliminar' class='fa fa-remove '  style='color:#F3D8D5'/></div><span > </span>";
                    edit = "<div  title= 'Editar'  class='fa fa-pencil ' style='color:#ABEBC6'/></div><span > </span>";
                    Lock = "<div title= 'Activar' class='fa fa-lock '  style='cursor: pointer; color:gray' onclick=appresolution.updateItemStatus(\""+rowObject.id+"\",'1')/></div><span > </span>";
                }
                if (rowObject.isDefault==1)
                {
                     Delete = "<div title= 'Eliminar' class='fa fa-remove '  style='color:#F3D8D5'/></div><span > </span>";
                }

                return Lock + edit + Delete;
            }   
            function state_mask(cellvalue, options, rowObject) {
                
                if (cellvalue==1)
                {
                    return "<div><p><span class='label label-primary'>Activo</span></p>"
                }
                else{
                      return "<p><span class='label label-warning'>Inactivo</span></p>"
                }
            }

            function default_mask(cellvalue, options, rowObject) {
                if (cellvalue==1)
                {
                    return 'Si'
                }
                else{
                     return 'No'
                }
            }

            


             $(window).bind('resize', function () {
               resizewidth();
            });
                //resize on load
            function resizewidth()
            {
                var width = $('.jqGrid_wrapper').width();
                $('#resolution-grid').setGridWidth(width); 
            } 

        });


    </script>

