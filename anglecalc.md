### Prelimary stuff
*Using IBone:*
```java
public void poseUpdate(String modelname){
  //not sure how necessary rotY will be. Depends on circumstances I suppose...

  //rotation
  public float rotX;
  public float rotY;
  public float rotZ;

  //position of part
  public float posX;
  public float posY;
  public float posZ;

  //pivot point. rotation gets offset here in the model, so we have to adjust our hitboxes accordingly.
  public float pivX;
  public float pivY;
  public float pivZ;
}
```
