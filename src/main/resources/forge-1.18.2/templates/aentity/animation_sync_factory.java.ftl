package ${package}.init;

@Mod.EventBusSubscriber
public class EntityAnimationFactory {

	@SubscribeEvent
	public static void onEntityTick(LivingEvent.LivingUpdateEvent event) {
	if (event != null && event.getEntity() != null) {
	<#list animatedentitys as syncable>
	if (event.getEntity() instanceof ${syncable.getModElement().getName()}Entity syncable) {
		String animation = syncable.getSyncedAnimation();
		if (!animation.equals("undefined")) {
			syncable.setAnimation("undefined");
			syncable.animationprocedure = animation;
			}
		}
	</#list>
		}
	}

}