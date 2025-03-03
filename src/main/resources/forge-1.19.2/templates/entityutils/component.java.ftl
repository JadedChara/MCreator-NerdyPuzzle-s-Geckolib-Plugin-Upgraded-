<#--
 # MCreator (https://mcreator.net/)
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2022, Pylo, opensource contributors
 #
 # This program is free software: you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 #
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <https://www.gnu.org/licenses/>.
 #
 # Additional permission for code generator templates (*.ftl files)
 #
 # As a special exception, you may create a larger work that contains part or
 # all of the MCreator code generator templates (*.ftl files) and distribute
 # that work under terms of your choice, so long as that work isn't itself a
 # template for code generation. Alternatively, if you modify or redistribute
 # the template itself, you may (at your option) remove this special exception,
 # which will cause the template and the resulting code generator output files
 # to be licensed under the GNU General Public License without this special
 # exception.
-->

<#-- @formatter:off -->

/*
 *    MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.entity.utils;

import net.minecraft.world.entity.Mob;
import net.minecraftforge.entity.PartEntity;
import net.minecraft.world.entity.EntityDimensions;
import net.minecraft.world.entity.Pose;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.entity.Entity;
import net.minecraft.nbt.CompoundTag;

public class Component<T extends Mob> extends PartEntity<T>{
  
  //A shit-ton of math will need to be done to manage angle calculations and read the untextured .geo and .anim JSONs. Not looking forward to it because it's something I had gotten rusty at. Will probably model this in NodeJS before I try it here.
  public final T parent;
	public final String name;
	public final EntityDimensions size;

  //What actually gets called. Still work-in-progress.
	public Component(T subParent, String preName, float width, float height){
		super(subParent);
		size = EntityDimensions.scalable(width, height);
		refreshDimensions();
		parent = subParent;
		this.name = preName;
	}

  //Configuration nonsense. Whoop-de-doo.
  //Preset Data
	@Override
	public EntityDimensions getDimensions(Pose pose){
		return size;
	}
	@Override
	public boolean isPickable(){
		return true;
	}
	@Override
	public boolean is(Entity preEnt){
		return this == preEnt || parent == preEnt;
	}
	@Override
	public boolean hurt(DamageSource source, float amount){
		return !isInvulnerableTo(source) && this.getParent().hurt(source, amount);
	}
	@Override
	protected void defineSynchedData(){
	}
	@Override
  protected void readAdditionalSaveData(CompoundTag tag) {
  }

  @Override
  protected void addAdditionalSaveData(CompoundTag tag) {
  }
  //Posing Management (Maybe some method to adjust hitboxes? I'm new to this lol)
  /*WIP*/
}
