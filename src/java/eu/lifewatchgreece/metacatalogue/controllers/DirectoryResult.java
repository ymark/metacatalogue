package eu.lifewatchgreece.metacatalogue.controllers;

/**
 * Used by Basic Search functionality to store the results
 * 
 * @license MIT
 * @author Alexandros Gougousis
 */
public class DirectoryResult {
    
    private String datasetName;
    private String datasetId;
    private String ownerName;
    private String ownerId;
    private String curatorName;
    private String curatorId;
    private String contactPoint;
    private String note;
    private String accessMethod;
    private String location;
    private String parentDataset;
    private String parentDatasetId;
    private String accessRights;
    private String accessRightsId;
    private String rightsHolder;
    private String rightsHolderId;
    private String keeperName;
    private String keeperId;
    private String publisherName;
    private String publisherId;
    private String contributorName;
    private String contributorId;
    private String creationEvent;
    private String creationDate;
    private String creatorName;
    private String creatorId;

    /**
     * @return the datasetName
     */
    public String getDatasetName() {
        return datasetName;
    }

    /**
     * @param datasetName the datasetName to set
     */
    public void setDatasetName(String datasetName) {
        this.datasetName = datasetName;
    }

    /**
     * @return the datasetId
     */
    public String getDatasetId() {
        return datasetId;
    }

    /**
     * @param datasetId the datasetId to set
     */
    public void setDatasetId(String datasetId) {
        this.datasetId = datasetId;
    }

    /**
     * @return the ownerName
     */
    public String getOwnerName() {
        return ownerName;
    }

    /**
     * @param ownerName the ownerName to set
     */
    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
    }

    /**
     * @return the ownerId
     */
    public String getOwnerId() {
        return ownerId;
    }

    /**
     * @param ownerId the ownerId to set
     */
    public void setOwnerId(String ownerId) {
        this.ownerId = ownerId;
    }

    /**
     * @return the curatorName
     */
    public String getCuratorName() {
        return curatorName;
    }

    /**
     * @param curatorName the curatorName to set
     */
    public void setCuratorName(String curatorName) {
        this.curatorName = curatorName;
    }

    /**
     * @return the curatorId
     */
    public String getCuratorId() {
        return curatorId;
    }

    /**
     * @param curatorId the curatorId to set
     */
    public void setCuratorId(String curatorId) {
        this.curatorId = curatorId;
    }

    /**
     * @return the contactPoint
     */
    public String getContactPoint() {
        return contactPoint;
    }

    /**
     * @param contactPoint the contactPoint to set
     */
    public void setContactPoint(String contactPoint) {
        this.contactPoint = contactPoint;
    }

    /**
     * @return the description
     */
    public String getNote() {
        return note;
    }

    /**
     * @param description the description to set
     */
    public void setNote(String note) {
        this.note = note;
    }

    /**
     * @return the accessMethod
     */
    public String getAccessMethod() {
        return accessMethod;
    }

    /**
     * @param accessMethod the accessMethod to set
     */
    public void setAccessMethod(String accessMethod) {
        this.accessMethod = accessMethod;
    }

    /**
     * @return the location
     */
    public String getLocation() {
        return location;
    }

    /**
     * @param location the location to set
     */
    public void setLocation(String location) {
        this.location = location;
    }

    /**
     * @return the parentDataset
     */
    public String getParentDataset() {
        return parentDataset;
    }

    /**
     * @param parentDataset the parentDataset to set
     */
    public void setParentDataset(String parentDataset) {
        this.parentDataset = parentDataset;
    }

    /**
     * @return the parentDatasetId
     */
    public String getParentDatasetId() {
        return parentDatasetId;
    }

    /**
     * @param parentDatasetId the parentDatasetId to set
     */
    public void setParentDatasetId(String parentDatasetId) {
        this.parentDatasetId = parentDatasetId;
    }

    /**
     * @return the accessRights
     */
    public String getAccessRights() {
        return accessRights;
    }

    /**
     * @param accessRights the accessRights to set
     */
    public void setAccessRights(String accessRights) {
        this.accessRights = accessRights;
    }

    /**
     * @return the accessRightsId
     */
    public String getAccessRightsId() {
        return accessRightsId;
    }

    /**
     * @param accessRightsId the accessRightsId to set
     */
    public void setAccessRightsId(String accessRightsId) {
        this.accessRightsId = accessRightsId;
    }

    /**
     * @return the rightsHolder
     */
    public String getRightsHolder() {
        return rightsHolder;
    }

    /**
     * @param rightsHolder the rightsHolder to set
     */
    public void setRightsHolder(String rightsHolder) {
        this.rightsHolder = rightsHolder;
    }

    /**
     * @return the rightsHolderId
     */
    public String getRightsHolderId() {
        return rightsHolderId;
    }

    /**
     * @param rightsHolderId the rightsHolderId to set
     */
    public void setRightsHolderId(String rightsHolderId) {
        this.rightsHolderId = rightsHolderId;
    }

    /**
     * @return the keeperName
     */
    public String getKeeperName() {
        return keeperName;
    }

    /**
     * @param keeperName the keeperName to set
     */
    public void setKeeperName(String keeperName) {
        this.keeperName = keeperName;
    }

    /**
     * @return the keeperId
     */
    public String getKeeperId() {
        return keeperId;
    }

    /**
     * @param keeperId the keeperId to set
     */
    public void setKeeperId(String keeperId) {
        this.keeperId = keeperId;
    }

    /**
     * @return the publisherName
     */
    public String getPublisherName() {
        return publisherName;
    }

    /**
     * @param publisherName the publisherName to set
     */
    public void setPublisherName(String publisherName) {
        this.publisherName = publisherName;
    }

    /**
     * @return the publsherId
     */
    public String getPublisherId() {
        return publisherId;
    }

    /**
     * @param publsherId the publsherId to set
     */
    public void setPublisherId(String publisherId) {
        this.publisherId = publisherId;
    }

    /**
     * @return the contributorName
     */
    public String getContributorName() {
        return contributorName;
    }

    /**
     * @param contributorName the contributorName to set
     */
    public void setContributorName(String contributorName) {
        this.contributorName = contributorName;
    }

    /**
     * @return the contributorId
     */
    public String getContributorId() {
        return contributorId;
    }

    /**
     * @param contributorId the contributorId to set
     */
    public void setContributorId(String contributorId) {
        this.contributorId = contributorId;
    }

    /**
     * @return the creationEvent
     */
    public String getCreationEvent() {
        return creationEvent;
    }

    /**
     * @param creationEvent the creationEvent to set
     */
    public void setCreationEvent(String creationEvent) {
        this.creationEvent = creationEvent;
    }

    /**
     * @return the creationName
     */
    public String getCreationDate() {
        return creationDate;
    }

    /**
     * @param creationName the creationName to set
     */
    public void setCreationDate(String creationDate) {
        this.creationDate = creationDate;
    }

    /**
     * @return the creatorName
     */
    public String getCreatorName() {
        return creatorName;
    }

    /**
     * @param creatorName the creatorName to set
     */
    public void setCreatorName(String creatorName) {
        this.creatorName = creatorName;
    }

    /**
     * @return the creatorId
     */
    public String getCreatorId() {
        return creatorId;
    }

    /**
     * @param creatorId the creatorId to set
     */
    public void setCreatorId(String creatorId) {
        this.creatorId = creatorId;
    }
    
}
