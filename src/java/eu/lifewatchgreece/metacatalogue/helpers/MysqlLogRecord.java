package eu.lifewatchgreece.metacatalogue.helpers;

import java.sql.Timestamp;

/**
 * A class to carry log item information
 * 
 * @license MIT
 * @author Alexandros Gougousis
 */
public class MysqlLogRecord {
    
    private String user_email;
    private String action;
    private String message;
    private Timestamp when;    

    /**
     * @return the user_email
     */
    public String getUser_email() {
        return user_email;
    }

    /**
     * @param user_email the user_email to set
     */
    public void setUser_email(String user_email) {
        this.user_email = user_email;
    }

    /**
     * @return the action
     */
    public String getAction() {
        return action;
    }

    /**
     * @param action the action to set
     */
    public void setAction(String action) {
        this.action = action;
    }

    /**
     * @return the message
     */
    public String getMessage() {
        return message;
    }

    /**
     * @param message the message to set
     */
    public void setMessage(String message) {
        this.message = message;
    }

    /**
     * @return the when
     */
    public Timestamp getWhen() {
        return when;
    }

    /**
     * @param when the when to set
     */
    public void setWhen(Timestamp when) {
        this.when = when;
    }
    
    
    
}
