package eu.lifewatchgreece.metacatalogue.helpers;

/**
 * A class to carry information about a toast message
 * 
 * @license MIT
 * @author Nikos Minadakis
 */
public class ToastMessage {
    
    private String messageType;
    private String messageString;

    /**
     * @return the messageType
     */
    public String getMessageType() {
        return messageType;
    }

    /**
     * @param messageType the messageType to set
     */
    public void setMessageType(String messageType) {
        this.messageType = messageType;
    }

    /**
     * @return the messageString
     */
    public String getMessageString() {
        return messageString;
    }

    /**
     * @param messageString the messageString to set
     */
    public void setMessageString(String messageString) {
        this.messageString = messageString;
    }
    
    
    
}
