package eu.lifewatchgreece.metacatalogue.helpers;

import com.google.gson.Gson;
import eu.lifewatch.core.impl.VirtuosoRepositoryManager;
import eu.lifewatch.core.model.DirectoryStruct;
import eu.lifewatch.exception.QueryExecutionException;
import eu.lifewatch.exception.RepositoryConnectionException;
import eu.lifewatch.service.impl.DirectoryService;
import eu.lifewatchgreece.metacatalogue.controllers.DirectoryResult;
import eu.lifewatchgreece.metacatalogue.models.Tables;
import eu.lifewatchgreece.metacatalogue.models.tables.Datasets;
import static eu.lifewatchgreece.metacatalogue.models.tables.Datasets.DATASETS;
import eu.lifewatchgreece.metacatalogue.models.tables.Logs;
import static eu.lifewatchgreece.metacatalogue.models.tables.Logs.LOGS;
import eu.lifewatchgreece.metacatalogue.models.tables.Settings;
import static eu.lifewatchgreece.metacatalogue.models.tables.Settings.SETTINGS;
import eu.lifewatchgreece.metacatalogue.models.tables.records.DatasetsRecord;
import eu.lifewatchgreece.metacatalogue.models.tables.records.LogsRecord;
import eu.lifewatchgreece.metacatalogue.models.tables.records.SettingsRecord;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import lombok.extern.log4j.Log4j;
import org.jooq.DSLContext;
import org.jooq.Result;
import org.jooq.SQLDialect;
import org.jooq.impl.DSL;



/**
 * Implements basic functionality that is useful to a number of servlets 
 * 
 * @license MIT
 * @author Alexandros Gougousis
 */
@Log4j
public class MyHttpServlet extends HttpServlet {
//    private final Logger log=org.apache.log4j.Logger.getLogger(MyHttpServlet.class);
    protected String baseUrl;
        
    protected String virtuosoUrl;
    protected String virtuosoPort;
    protected String virtuosoUser;
    protected String virtuosoPass;
    protected String virtuosoJdbc;
    
    protected String directoryGraph;
    protected String metadataGraph;
    protected String materializationGraph;
    
    protected String irodsIP;
    protected int irodsPort;
    protected String irodsUsername;
    protected String irodsPassword;
    protected String irodsPath;
    protected String irodsTempZone;
    protected String irodsDemoResc;
    
    protected String descriptionPath;
    protected String internalMetadataPath;
    protected String internalDatasetPath;
    protected String datasetPath;
    protected String directoryRecoveryPath;
    protected String uriPrefix;
    
    protected String mysqlUser;
    protected String mysqlPwd;
    protected String mysqlUrl;
    protected Connection conn;
    public static Set<String> datasetTypes;
    
    protected int rpp;  // results per page (for pagination)
    protected int ppm;  // pages per menu (for pagination)
    
    protected HashMap<String,String> settings;
    
    @Override
    public void init(ServletConfig config) throws ServletException{
        super.init(config);
        log.debug("Initializing MyHttpServlet");
        
        // Load hard-coded settings from web.xml
        mysqlUser = config.getServletContext().getInitParameter("mysqlUser"); 
        mysqlPwd = config.getServletContext().getInitParameter("mysqlPwd"); 
        mysqlUrl = config.getServletContext().getInitParameter("mysqlUrl");                
        baseUrl = config.getServletContext().getInitParameter("metacatalogueBaseUrl"); 
        
        // Load dynamic settings from database
        settings = new HashMap<String,String>();
        ArrayList<SystemSetting> system_settings = getSystemSettings();
        log.debug("count settings = "+system_settings);
        for(SystemSetting item : system_settings){
            settings.put(item.getSname(),item.getSvalue());
        }
        
        // Assign settings to protected properties so that can be accessed by child-classes                        
        virtuosoUrl = settings.get("virtuosoUrl"); 
        virtuosoPort = settings.get("virtuosoPort"); 
        virtuosoUser = settings.get("virtuosoUser"); 
        virtuosoPass = settings.get("virtuosoPass"); 
        virtuosoJdbc = settings.get("virtuosoJdbc"); 
        
        directoryGraph = settings.get("directoryGraph");
        metadataGraph = settings.get("metadataGraph");
        materializationGraph = settings.get("materializationGraph");
        
        irodsIP = settings.get("irodsIP");
        irodsPort = Integer.parseInt(settings.get("irodsPort"));
        irodsUsername = settings.get("irodsUsername");
        irodsPassword = settings.get("irodsPassword");
        irodsPath = settings.get("irodsPath");
        irodsTempZone = settings.get("irodsTempZone");
        irodsDemoResc = settings.get("irodsDemoResc");
        
        descriptionPath = settings.get("descriptionPath");
        internalMetadataPath = settings.get("internalMetadataPath");
        internalDatasetPath = settings.get("internalDatasetPath");
        datasetPath = settings.get("datasetPath");
        directoryRecoveryPath = settings.get("directoryRecoveryPath"); 
        uriPrefix = settings.get("uriPrefix");
        
        rpp = Integer.parseInt(settings.get("rpp"));
        ppm = Integer.parseInt(settings.get("ppm"));     
        
//        try{
//            VirtuosoRepositoryManager repoManager = new VirtuosoRepositoryManager(virtuosoUrl,virtuosoPort,virtuosoUser,virtuosoPass);
//            DirectoryService directoryService=new DirectoryService(repoManager);
//            datasetTypes=directoryService.retrieveDatasetTypes(directoryGraph);
//        }catch(RepositoryConnectionException | QueryExecutionException ex){
//            log.error("An error occured while retrieving the available dataset types");
//            datasetTypes=new HashSet<>();
//        }
        
        log.debug("Successfully initialized MyHttpServlet");
    }
    
    /**
     * Displays an HTML page that includes a specific error message
     * 
     * @param response
     * @param errorMEssage
     * @throws ServletException
     * @throws IOException 
     */
    protected void displayError(HttpServletResponse response, String errorMEssage) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Unexpected Error!</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<strong>Error: </strong>"+errorMEssage);
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
        }
    }
    
    /**
     * Outputs a text message to the browser
     * 
     * @param response
     * @param message
     * @throws ServletException
     * @throws IOException 
     */
    protected void displayMessage(HttpServletResponse response, String message) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            out.println(message);
        } finally {
            out.close();
        }
    }
    
    /**
     * Retrieves a POSTed form field, replacing null value with empty string
     * 
     * @param request
     * @param fieldName
     * @return  A string that represents the posted value (empty string for empty field)
     */
    protected String getTextFormField(HttpServletRequest request, String fieldName){
        String fieldValue = request.getParameter(fieldName);
        if (fieldValue == null){
            return "";
        } else {
            return fieldValue;
        }
    }
    
    /**
     * Retrieves the description of a dataset
     * 
     * @param request
     * @param dataset_name
     * @return  The description of the dataset or NULL.
     */
    protected DirectoryStruct getDatasetInfo(HttpServletRequest request,String dataset_name){

        ArrayList<DirectoryResult> results = new ArrayList<DirectoryResult>();
        try
        {
            // Establish a connection to Virtuoso repository
            VirtuosoRepositoryManager directoryManager = new VirtuosoRepositoryManager(virtuosoUrl,virtuosoPort,virtuosoUser,virtuosoPass);                                                
            
            // Search and retrieve the results
            List<DirectoryStruct> dservice = new DirectoryService(directoryManager).searchDataset("",dataset_name,"","","","","","",-1,-1,directoryGraph);                        
            
            DirectoryStruct dataset;
            if(dservice.size() > 0){
                dataset = dservice.get(0);
                return dataset;
            } else {               
                Gson gson = new Gson();
                String json = gson.toJson(dservice);                
                return null;
            }
                                    
        }
        catch (RepositoryConnectionException ex)
        {
            log2db(request,"Exception",ex.getMessage());
            return null;
        }
        catch (QueryExecutionException ex)
        {
            log2db(request,"Exception",ex.getMessage());
            return null;
        }
    }
    
    /**
     * Checks out if a dataset has been created (belongs to) by a certain user
     * 
     * @param request
     * @param datasetName
     * @return  A boolean that indicates if the dataset has been created by the specified user
     */
    protected boolean datasetBelongsToUser(HttpServletRequest request,String datasetName){
        try {
            if((this.conn == null)||(!this.conn.isValid(4))){
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                this.conn = DriverManager.getConnection(mysqlUrl, mysqlUser, mysqlPwd);
            }
                        
            HttpSession session = request.getSession(false);
            String user_email = (String) session.getAttribute("user_email");
            
            DSLContext database = DSL.using(this.conn, SQLDialect.MYSQL);
            Datasets dat = DATASETS.as("dat");
            int count = database.selectFrom(dat)
                            .where(dat.NAME.equal(datasetName))
                            .and(dat.USER_EMAIL.equal(user_email))
                            .fetchOne(0, int.class);;
            
            if(count > 0){
                return true;
            } else {
                return false;
            }
                            
        } catch (Exception ex){
            log.error(ex.getMessage());
            return false;
        }
    }
    
    /**
     * Checks out if a dataset with a specific name exists
     * 
     * @param datasetName
     * @return  A boolean that indicates if a dataset which such a name exists
     */
    protected boolean datasetExists(String datasetName){
        try {
            if((this.conn == null)||(!this.conn.isValid(4))){
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                this.conn = DriverManager.getConnection(mysqlUrl, mysqlUser, mysqlPwd);
            }            
            
            log.debug("Looking for dataset = "+datasetName);
            DSLContext database = DSL.using(this.conn, SQLDialect.MYSQL);
            Datasets dat = DATASETS.as("dat");
            /*
            int count = database.selectFrom(dat)
                            .where(dat.NAME.equal(datasetName))                            
                            .fetchOne(0, int.class);
            logText("count = "+count);
                    */
            
            Result<DatasetsRecord> results = database.selectFrom(dat)
                                                .where(dat.NAME.equal(datasetName))                                               
                                                .fetch();    
            
            log.debug("count = "+results.size());
            if(results.size() > 0){
                return true;
            } else {
                return false;
            }
                            
        } catch (Exception ex){
            log.error(ex.getMessage());
            return false;
        }
    }
    
    /**
     * Retrieves system settings from database
     * 
     * @return  An ArrayList with settings or NULL
     */
    protected ArrayList<SystemSetting> getSystemSettings(){
        
        try {
            log.debug("Entered in getSystemSettings");
            if((this.conn == null)||(!this.conn.isValid(4))){
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                this.conn = DriverManager.getConnection(mysqlUrl, mysqlUser, mysqlPwd);
            }
            log.debug("Connected");

            ArrayList<SystemSetting> settingList = new ArrayList<SystemSetting>();

            DSLContext database = DSL.using(this.conn, SQLDialect.MYSQL);
            Settings set = SETTINGS.as("set");
            Result<SettingsRecord> results = database.selectFrom(set).fetch();                
            log.debug("Executed Query");
            for(SettingsRecord item: results){

                SystemSetting settingObj = new SystemSetting();
                settingObj.setSname(item.getName());
                settingObj.setSvalue(item.getValue());
                settingObj.setAbout(item.getAbout());
                settingObj.setLastModified(item.getLastModified());
                settingList.add(settingObj);
            }                                  
            
            return settingList;
            
        } catch (Exception ex){
            log.error("Encountered Exc",ex);
            ex.printStackTrace();
            return null;
        }
        
    }
    
    /**
     * Updates a specific system setting
     * 
     * @param settingName
     * @param settingValue 
     */
    protected void setSystemSetting(String settingName, String settingValue){
        
        try {                        
            if((this.conn == null)||(!this.conn.isValid(4))){
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                this.conn = DriverManager.getConnection(mysqlUrl, mysqlUser, mysqlPwd);
            }

            DSLContext database = DSL.using(this.conn, SQLDialect.MYSQL);
            Settings set = SETTINGS.as("set");
            database.update(set)
                .set(set.VALUE,settingValue)
                .where(set.NAME.equal(settingName))
                .execute();     
                                   
        } catch (Exception ex){
            log.error(ex.getMessage());            
        }
        
    }
    
    /**
     * Retrieves a list of the datasets that has been created by (belong to) the logged in user
     * 
     * @param request
     * @return  An ArrayList with dataset names or NULL
     */
    protected ArrayList<String> getUserDatasets(HttpServletRequest request){
        try {                        
            if((this.conn == null)||(!this.conn.isValid(4))){
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                this.conn = DriverManager.getConnection(mysqlUrl, mysqlUser, mysqlPwd);
            }

            ArrayList<String> datasetList = new ArrayList<String>();
            
            HttpSession session = request.getSession(false);
            String user_email = (String) session.getAttribute("user_email");

            if(user_email != null){
                DSLContext database = DSL.using(this.conn, SQLDialect.MYSQL);
                Datasets dat = DATASETS.as("dat");
                Result<DatasetsRecord> results = database.selectFrom(dat)
                                                    .where(dat.USER_EMAIL.equal(user_email))
                                                    .orderBy(dat.NAME.asc())
                                                    .fetch();                
                for(DatasetsRecord item: results){
                    datasetList.add(item.getName());
                }                
            }                
            
            return datasetList;
            
        } catch (Exception ex){
            log.error(ex.getMessage());
            return null;
        }
    }
    
    /**
     * Retrieves the most recent logs from database
     * 
     * @param howMany  How many log items to retrieve
     * @return  An ArrayList with log items or NULL
     */
    protected ArrayList<MysqlLogRecord> getMysqlLogs(int howMany){
        try {                        
            if((this.conn == null)||(!this.conn.isValid(4))){
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                this.conn = DriverManager.getConnection(mysqlUrl, mysqlUser, mysqlPwd);
            }

            ArrayList<MysqlLogRecord> datasetList = new ArrayList<MysqlLogRecord>();            

            DSLContext database = DSL.using(this.conn, SQLDialect.MYSQL);
            Logs logs = LOGS.as("log");
            Result<LogsRecord> results = database.selectFrom(logs)
                                                .orderBy(logs.WHEN.desc())
                                                .limit(howMany)
                                                .fetch();                
            for(LogsRecord item: results){
                MysqlLogRecord record = new MysqlLogRecord();
                record.setAction(item.getAction());
                record.setUser_email(item.getUserEmail());
                record.setMessage(item.getMessage());
                record.setWhen(item.getWhen());
                datasetList.add(record);
            }                               
            
            return datasetList;
            
        } catch (Exception ex){
            log.error(ex.getMessage());
            return null;
        }
    }
    
    /**
     * Stores in the database a log item that relates to a specific dataset
     * 
     * @param request
     * @param action  The log type
     * @param message  The log message
     * @param dataset  The dataset related to this log
     */
    protected void log2db(HttpServletRequest request, String action, String message, String dataset) {
        
        try {
            if((this.conn == null)||(!this.conn.isValid(4))){
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                this.conn = DriverManager.getConnection(mysqlUrl, mysqlUser, mysqlPwd);
            }

            HttpSession session = request.getSession(false);
            String user_email = (String) session.getAttribute("user_email");

            DSLContext database = DSL.using(this.conn, SQLDialect.MYSQL);

            LogsRecord logItem = database.newRecord(Tables.LOGS);
            logItem.setUserEmail(user_email);
            logItem.setAction(action);
            logItem.setMessage(message);
            logItem.setRelatedDataset(dataset);
            logItem.store();    
        } catch (Exception ex){
            log.error(ex.getMessage());
        }
        
    }

    /**
     * Stores in the database a log item
     * 
     * @param request
     * @param action  The log type
     * @param message  The log message
     */
    protected void log2db(HttpServletRequest request, String action, String message) {
        
        try {
            if((this.conn == null)||(!this.conn.isValid(4))){
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                this.conn = DriverManager.getConnection(mysqlUrl, mysqlUser, mysqlPwd);
            } 

            HttpSession session = request.getSession(false);
            String user_email = (String) session.getAttribute("user_email");

            DSLContext database = DSL.using(this.conn, SQLDialect.MYSQL);  

            LogsRecord logItem = database.newRecord(Tables.LOGS);
            logItem.setUserEmail(user_email);
            logItem.setAction(action);
            logItem.setMessage(message);
            logItem.store();  
        } catch (Exception ex){
            log.error(ex.getMessage());
        }
                
    }
    
    /**
     * Checks if a dataset can be modified/managed by a certain user
     * 
     * NOTE: This method is not implemented yet. For the moment it returns true if the dataset just exists.
     * 
     * @param request
     * @param datasetName
     * @return 
     */
    protected boolean datasetManagedByUser(HttpServletRequest request, String datasetName){
        
        try {
            if((this.conn == null)||(!this.conn.isValid(4))){
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                this.conn = DriverManager.getConnection(mysqlUrl, mysqlUser, mysqlPwd);
            } 

            HttpSession session = request.getSession(false);
            String user_email = (String) session.getAttribute("user_email");

            DSLContext database = DSL.using(this.conn, SQLDialect.MYSQL);  

            int count = database.selectCount()
                .from(Tables.DATASETS)
                .fetchOne(0, int.class);
            
            if (count > 0){
                return true;
            } else {
                return false;
            }
 
        } catch (Exception ex){
            log2db(request,"error","Checking out if a dataset belongs to user failed. Reason: "+ex.getMessage());
            return false;
        }
        
    }
    
    /**
     * Erases all datasets from database.
     * 
     * @param request 
     */
    protected void clearMyqlDatasets(HttpServletRequest request){
        try {
            if((this.conn == null)||(!this.conn.isValid(4))){
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                this.conn = DriverManager.getConnection(mysqlUrl, mysqlUser, mysqlPwd);
            } 

            HttpSession session = request.getSession(false);
            String user_email = (String) session.getAttribute("user_email");

            DSLContext database = DSL.using(this.conn, SQLDialect.MYSQL);  

            database.delete(Tables.DATASETS).execute();
            log2db(request,"info","User "+user_email+" cleared all datasets from MySQL.");
        } catch (Exception ex){
            log2db(request,"info","Deleting all datasets from MySQL in DB failed. Reason: "+ex.getMessage());
        }
    }
    
    /**
     * Saves a new dataset record in the database
     * 
     * @param request
     * @param datasetName 
     */
    protected void dataset2db(HttpServletRequest request, String datasetName){
        try {
            if((this.conn == null)||(!this.conn.isValid(4))){
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                this.conn = DriverManager.getConnection(mysqlUrl, mysqlUser, mysqlPwd);
            } 

            HttpSession session = request.getSession(false);
            String user_email = (String) session.getAttribute("user_email");

            DSLContext database = DSL.using(this.conn, SQLDialect.MYSQL);  

            DatasetsRecord record = database.newRecord(Tables.DATASETS);
            record.setUserEmail(user_email);
            record.setName(datasetName);
            record.store();  
        } catch (Exception ex){
            log2db(request,"error","Adding dataset record in DB failed. Reason: "+ex.getMessage());
        }
    }
    
//    /**
//     * Stores a log item in a log file
//     * 
//     * @param message  The message to be logged
//     */
//    protected void logText(String message){
//        
//        String logFilePath = this.getServletContext().getInitParameter("logFilePath");
//        PrintWriter out = null;
//        
//        try {
//            DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
//            Date date = new Date();
//            
//            out = new PrintWriter(new BufferedWriter(new FileWriter(logFilePath, true)));
//            out.println(dateFormat.format(date)+message);
//            out.close();
//        } catch (Exception ex) {
//            Logger.getLogger(MyHttpServlet.class.getName()).log(Level.SEVERE, null, ex);
//        }                   
//    }
    
    /**
     * Retrieve the most recent lines from the log file
     * 
     * @param howMany  The number of most recent lines to retrieve
     * @return 
     */
    protected LinkedList<String> getLastLinesFromTextLog(int howMany){
        
        String logFilePath = this.getServletContext().getInitParameter("logFilePath");
        FileInputStream in;
        BufferedReader br;
        LinkedList<String> lines;
        
        try {
            in = new FileInputStream(logFilePath);
            br = new BufferedReader(new InputStreamReader(in));
            lines = new LinkedList<String>();
            for(String tmp; (tmp = br.readLine()) != null;) {
                if (lines.add(tmp) && lines.size() > howMany) {
                    lines.remove(0);
                }
            }
            
            return lines;
            
        } catch (FileNotFoundException ex) {
            log.error(ex);
            return null;
        } catch (IOException ex) {
            log.error(ex);
            return null;
        }        
    }
}
